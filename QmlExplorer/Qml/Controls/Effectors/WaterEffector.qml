import QtQuick 2.3

/**
水纹效果
*/
ShaderEffect {
    width: source.width
    height: source.height
    property Item source
    property real amplitude: 0.007  // 0.02
    property real frequency: 20
    property real time: 0


    fragmentShader: "
        uniform sampler2D source;          // 图像源
        varying highp vec2 qt_TexCoord0;   // 当前点坐标
        uniform lowp float qt_Opacity;     // 整体不透明度
        uniform highp float frequency;     // 频率
        uniform highp float amplitude;     // 振幅
        uniform highp float time;          // 0-2PI
        void main() {
            // 当前点的色彩由“别处”漂移过来，计算这个“别处”的坐标
            vec2 pulse = sin(time - frequency * qt_TexCoord0);
            vec2 coord = qt_TexCoord0 + amplitude * vec2(pulse.y, -pulse.x);

            // 用“别处”的色彩作为当前点的色彩
            gl_FragColor = texture2D(source, coord) * qt_Opacity;
        }"

    property bool animationRunning : true;
    property int animationDuration : 1000;
    NumberAnimation on time {
        from: 0; to: Math.PI*2; loops: Animation.Infinite
        running: animationRunning
        duration: animationDuration;
    }
}
