import QtQuick 2.0


// wobble(摇晃）横向和纵向都有正弦变形
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property variant source : img
    property real dividerValue: 1
    property real amplitude: 0.5;  // 振幅
    property real frequency: 5;    // 数目
    property real time: 5;         // 时间


    fragmentShader: "
uniform float dividerValue;
uniform float amplitude;
uniform float frequency;
uniform float time;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec2 tc = qt_TexCoord0;
    if (uv.x < dividerValue) {
        vec2 p = sin(time + frequency * qt_TexCoord0);
        tc += amplitude * vec2(p.y, -p.x);
    }
    gl_FragColor = qt_Opacity * texture2D(source, tc);
}
        "

    property bool animationRunning : true;
    property int animationDuration : 1000;
    NumberAnimation on time {
        from: 0; to: Math.PI*2; loops: Animation.Infinite
        running: animationRunning
        duration: animationDuration;
    }
}
