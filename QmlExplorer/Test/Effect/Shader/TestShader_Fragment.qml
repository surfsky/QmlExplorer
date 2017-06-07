import QtQuick 2.0


/**
片段着色器(Fragment Shader)示例
    /灰度化
    /只保留红色通道
    /波浪效果
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
            source: '../images/tulips.jpg'
        }

        // 灰度化
        ShaderEffect {
            width: 100; height: width
            property variant source: sourceImage  // 属性
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

        // 只保留红色通道
        ShaderEffect {
            id: effect4
            width: 100; height: width
            property variant source: sourceImage
            property real redChannel: 0.3
            fragmentShader: "
               uniform sampler2D source;      // 外部传递进来的图片（常量、类型sample2D）
               uniform float redChannel;      // 红色通道比例（常量、类型float）
               uniform float qt_Opacity;      // 不透明度（常量，类型float）
               varying vec2 qt_TexCoord0;     // 当前点坐标（变量、类型vec2）
               void main() {
                   vec4 p = texture2D(source, qt_TexCoord0);       // 当前点色彩值
                   gl_FragColor = p * vec4(redChannel, 1.0, 1.0, 1.0) * qt_Opacity;
               }"
            // 将动画作用于redChannel变量，实现动画效果
            NumberAnimation on redChannel {
                from: 0.0; to: 1.0; loops: Animation.Infinite; duration: 2000
            }
        }

        // 波浪效果（此处用片段着色器实现，也可考虑用顶点着色器实现）
        ShaderEffect {
            width: 100; height: width
            property variant source: sourceImage
            property real frequency: 8
            property real amplitude: 0.1
            property real time: 0.0
            fragmentShader: "
                uniform sampler2D source;          // 图像源
                varying highp vec2 qt_TexCoord0;   // 当前点坐标
                uniform lowp float qt_Opacity;     // 整体不透明度
                uniform highp float frequency;     // 频率
                uniform highp float amplitude;     // 振幅
                uniform highp float time;          // 0-2PI
                void main() {
                    // 当前点的色彩由“别处”漂移过来，计算这个“别处”的坐标
                    highp vec2 pulse = sin(time - frequency * qt_TexCoord0);
                    highp vec2 coord = qt_TexCoord0 + amplitude * vec2(pulse.x, -pulse.x);

                    // 用“别处”的色彩作为当前点的色彩
                    gl_FragColor = texture2D(source, coord) * qt_Opacity;
                }"
            NumberAnimation on time {
                from: 0; to: Math.PI*2; duration: 1000; loops: Animation.Infinite
            }
        }
    }
}
