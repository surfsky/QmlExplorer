import QtQuick 2.0


/**
着色器（OpenGL Shader）
    充分利用gpu的并行计算能力，高速进行图像渲染
    shader代码都是针对单个点进行运算的，循环以及图像的边界都由Shader负责，代码中不用考虑，大大简化代码量
    分为两种：
        顶点着色器(Vertex Shader)
            一般用于控制形状
            正常情况下，ShaderEffect有4个顶点(左上，右上，左下，右下), 顶点类型vec4。
            修改这些点的位置, 其它的像素会根据插值算法自动调整位置
            修改mesh属性可以增加控制点
            每段vertexShader代码都会跑顶点数目次数
        片段着色器(Fragment Shader)
            作用于每个像素，可设置该像素的色彩
            每端fragmentShader代码都会跑 width*height 次
        处理流程
            --> 顶点着色器 --> 插值变形 -> 片段着色器 ->
        ps
            顶点着色器的性能好（由少数控制点控制图像变形，适合简单的变形）
            片段着色器用得更广泛（因为它控制了每个点的显示，还可以控制色彩）
            一般情况写片段着色器就行了

Qml ShaderEffect的图像源
    为 Image 或 ShaderEffectSource
    其它Item元素要加上 layer.enabled:true 语句


Qt类型映射到着色器类型
    bool, int, qreal -> bool, int, float
    QPoint, QPointF, QSize, QSizeF -> vec2
    QVector3D -> vec3
    QVector4D -> vec4
    QTransform -> mat3
    QMatrix4x4 -> mat4
    QRect, QRectF -> vec4(x,y,w,h)
    Image, ShaderEffectSource -> sampler2D
    QQuaternion -> vec4 四元数，用于表示旋转(x,y,z,w)
    QColor -> vec4
        色彩值被传递给shader后，会被预乘透明值（premultiplied alpha）
        如Qt.rgba(0.2, 0.6, 1.0, 0.5) 会变成vec4(0.1, 0.3, 0.5, 0.5), 原有的RGB值都乘上了ALPHA值
        这样做是出于性能考虑，图像处理算法在复合两张图片的时候总是需要将ALPHA通道的信息复合到各个颜色通道，因此如果你需要处理很多的图像复合时候，这样的做法就节省了很多的时间

输入参数
    预定义输入参数
        uniform mat4 qt_Matrix            // 变换矩阵, the product of the matrices from the root item to this ShaderEffect, and an orthogonal projection.
        uniform float qt_Opacity          // 不透明度, the product of the opacities from the root item to this ShaderEffect.
        attribute vec4 qt_Vertex          // 顶点坐标, the top-left vertex has position (0, 0), the bottom-right (width, height).
        attribute vec2 qt_MultiTexCoord0  // 纹理坐标, the top-left coordinate is (0, 0), the bottom-right (1, 1). If supportsAtlasTextures is true, coordinates will be based on position in the atlas instead.
        varying highp vec2 qt_TexCoord0;  // 当前点坐标（变量、类型vec2）
    输入图像
        uniform sampler2D source;         // 外部传递进来的图片（Image或ShaderEffectSource）

输出参数
    顶点着色器
        gl_Position = qt_Matrix * qt_Vertex;
    片段着色器
        vec4 c = texture2D(source, qt_TexCoord0);
        gl_FragColor = c * vec4(1.0, 0.0, 0.0, 1.0) * qt_Opacity;


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
            width: 80; height: width
            source: '../images/bug.png'
        }

        // 以下为基础代码结构
        ShaderEffect {
            id: effect2
            width: 80;
            height: width;

            //
            blending: false; // fragmentShader是否和下面的元素融合
            cullMode: ShaderEffect.NoCulling
            mesh: GridMesh { resolution: Qt.size(1, 1) }

            //
            property variant source: sourceImage         // 源图像
            property var minimize : 0.3                  // 缩小比例
            vertexShader: "
               uniform highp mat4 qt_Matrix;             // 变形矩阵（常量）
               attribute highp vec4 qt_Vertex;           // 顶点坐标（变量），范围：(0,0)-(width,height)
               attribute highp vec2 qt_MultiTexCoord0;   // 纹理坐标（变量），范围：(0,0)-(1,1)
               varying highp vec2 qt_TexCoord0;          // 当前点坐标（变量）
               uniform highp float minimize;             // 外部变量：缩放比例
               uniform highp float width;                // 外部变量：宽度
               uniform highp float height;               // 外部变量：高度
               void main() {
                   qt_TexCoord0 = qt_MultiTexCoord0;            // 保存纹理坐标
                   vec4 pos;                                    //
                   pos.x = mix(qt_Vertex.x, width, minimize);   // x线性插值
                   pos.y = mix(qt_Vertex.y, height, minimize);  // y线性插值
                   gl_Position = qt_Matrix * pos;               // 输出新的位置
               }"
            fragmentShader: "
                uniform sampler2D source;                // 外部传递进来的图片（常量）
                uniform float qt_Opacity;                // 不透明度（常量）
                varying vec2 qt_TexCoord0;               // 当前点坐标（变量）
                void main() {
                    vec4 c = texture2D(source, qt_TexCoord0);                  // 获取当前点色彩值
                    gl_FragColor = c * vec4(1.0, 0.0, 0.0, 1.0) * qt_Opacity;  // 输出处理后的色彩值
                }"
        }
    }
}

