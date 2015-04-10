import QtQuick 2.0

// 高斯模糊（横条纹高斯模糊）
ShaderEffect {
    id: shader
    width:source.width;
    height:source.height
    property Item source
    property real blurSize: 4.0
    property real dividerValue: 1.0


    fragmentShader: "
uniform float dividerValue;
uniform float blurSize;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec4 c = vec4(0.0);
    if (uv.x < dividerValue) {
        c += texture2D(source, uv - vec2(4.0*blurSize, 0.0)) * 0.05;
        c += texture2D(source, uv - vec2(3.0*blurSize, 0.0)) * 0.09;
        c += texture2D(source, uv - vec2(2.0*blurSize, 0.0)) * 0.12;
        c += texture2D(source, uv - vec2(1.0*blurSize, 0.0)) * 0.15;
        c += texture2D(source, uv) * 0.18;
        c += texture2D(source, uv + vec2(1.0*blurSize, 0.0)) * 0.15;
        c += texture2D(source, uv + vec2(2.0*blurSize, 0.0)) * 0.12;
        c += texture2D(source, uv + vec2(3.0*blurSize, 0.0)) * 0.09;
        c += texture2D(source, uv + vec2(4.0*blurSize, 0.0)) * 0.05;
    } else {
        c = texture2D(source, qt_TexCoord0);
    }
    gl_FragColor = qt_Opacity * c;
}
        "
}
