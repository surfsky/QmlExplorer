import QtQuick 2.0
import "../../Controls/Effectors"

/**
顶点着色器(Vertex Shader)示例
    /缩小
    /梯形变形
    /曲线变形
参考：http://cwc1987.gitbooks.io/qt5cadaquesinchinese/content/shader_effect/vertex_shader.html
*/
Rectangle {
    width: 480; height: 240
    color: '#1e1e1e'

    Grid {
        anchors.centerIn: parent
        spacing: 20
        rows: 2; columns: 4
        Image {
            id: sourceImage
            width: 100; height: width
            source: '../images/bug.png'
        }

        // 缩小
        /*
          px = mix(x, w, m) = x(1-m)+wm;
          py = mix(y, h, m) = y(1-m)+hm;
          (0,0) -> (0.5w,     0.5h)
          (w,0) -> (w,        0.5h)
          (w,h) -> (w,        h)
          (0,w) -> (0.5w,     h)
        */
        ShaderEffect {
            width: 100; height: width
            property var source: sourceImage  // 属性
            property var minimize : 0.3       // 缩小比例
            vertexShader: "
               uniform highp mat4 qt_Matrix;
               attribute highp vec4 qt_Vertex;
               attribute highp vec2 qt_MultiTexCoord0;
               varying highp vec2 qt_TexCoord0;
               uniform highp float minimize;
               uniform highp float width;
               uniform highp float height;
               void main() {
                   qt_TexCoord0 = qt_MultiTexCoord0;            // 保存纹理坐标
                   vec4 pos;                                    //
                   pos.x = mix(qt_Vertex.x, width, minimize);   // x线性插值
                   pos.y = mix(qt_Vertex.y, height, minimize);  // y线性插值
                   gl_Position = qt_Matrix * pos;               // 输出新的位置
               }"
        }

        // x收缩得比y快
        ShaderEffect {
            width: 100; height: width
            property var source: sourceImage  // 属性
            property var minimize : 0.3       // 缩小比例
            vertexShader: "
               uniform highp mat4 qt_Matrix;
               attribute highp vec4 qt_Vertex;
               attribute highp vec2 qt_MultiTexCoord0;
               varying highp vec2 qt_TexCoord0;
               uniform highp float minimize;
               uniform highp float width;
               uniform highp float height;
               void main() {
                   qt_TexCoord0 = qt_MultiTexCoord0;
                   vec4 pos;
                   pos.y = mix(qt_Vertex.y, height, minimize);    // y线性插值
                   float t = pos.y / height;
                   pos.x = mix(qt_Vertex.x, width, t * minimize); // x值的插值基于当前顶点的y坐标
                   gl_Position = qt_Matrix * pos;
               }"
        }


        // x按3次曲线收缩
        ShaderEffect {
            width: 100; height: width
            mesh: GridMesh { resolution: Qt.size(16, 16) }  // 增加顶点数目
            property var source: sourceImage                // 属性
            property var minimize : 0.3                     // 缩小比例
            property var bend : 0.7                         // 弯曲程度
            vertexShader: "
                uniform highp mat4 qt_Matrix;
                attribute highp vec4 qt_Vertex;
                attribute highp vec2 qt_MultiTexCoord0;
                uniform highp float height;
                uniform highp float width;
                uniform highp float minimize;
                uniform highp float bend;
                varying highp vec2 qt_TexCoord0;
                void main() {
                    qt_TexCoord0 = qt_MultiTexCoord0;
                    vec4 pos;
                    pos.y = mix(qt_Vertex.y, height, minimize);  // y线性插值
                    float t = pos.y / height;
                    t = (3.0 - 2.0 * t) * t * t;
                    pos.x = mix(qt_Vertex.x, width, t * bend);   // x按3次曲线收缩
                    gl_Position = qt_Matrix * pos;
                }"
        }


        // 指定收缩位置
        ShaderEffect {
            width: 100; height: width
            mesh: GridMesh { resolution: Qt.size(16, 16) }  // 增加顶点
            property var source: sourceImage                // 属性
            property var minimize : 0.3                     // 缩小比例
            property var bend : 0.7                         // 弯曲程度
            property var side : 0.5                         // 收缩目标位置
            vertexShader: "
                uniform highp mat4 qt_Matrix;
                attribute highp vec4 qt_Vertex;
                attribute highp vec2 qt_MultiTexCoord0;
                uniform highp float height;
                uniform highp float width;
                uniform highp float minimize;
                uniform highp float bend;
                uniform highp float side;
                varying highp vec2 qt_TexCoord0;
                void main() {
                    qt_TexCoord0 = qt_MultiTexCoord0;
                    vec4 pos;
                    pos.y = mix(qt_Vertex.y, height, minimize);        // y线性插值
                    float t = pos.y / height;
                    t = (3.0 - 2.0 * t) * t * t;
                    pos.x = mix(qt_Vertex.x, side * width, t * bend);  // x按3次曲线收缩
                    gl_Position = qt_Matrix * pos;
                }"
        }

        // 加上动画封装成组件
        GenieEffector{
            source: sourceImage
            width: 100; height:width
            side: 0.5
            MouseArea{
                anchors.fill: parent
                onClicked: parent.minimized = !parent.minimized
            }
        }
    }
}


