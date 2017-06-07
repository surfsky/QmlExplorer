import QtQuick 2.0

/**
测试item.layer属性
相当于给item作用了一个shader
更多shader知识请查看Effect>Shader章节
*/
Rectangle {
    width: 600
    height: 400


    Rectangle{
        id: txt
        width: 200
        height: 200
        anchors.centerIn: parent

        // 原本色彩是蓝色的
        color: 'blue'

        // 运用shader，变成灰色
        layer.enabled: true
        layer.effect: ShaderEffect {
            width: 100; height: 100
            property variant src: txt
            fragmentShader: "
                uniform sampler2D source;    // 外部传递进来的图片（常量、类型sample2D）
                uniform float qt_Opacity;    // 不透明度（常量，类型float）
                varying vec2 qt_TexCoord0;   // 当前点坐标（变量、类型vec2）
                void main() {
                    vec4 p = texture2D(source, qt_TexCoord0);       // 当前点色彩值
                    float g = dot(p.xyz, vec3(0.344, 0.5, 0.156));  // 灰度值
                    gl_FragColor = vec4(g, g, g, p.a) * qt_Opacity; // 输出灰度值
                }"
        }
    }
}
