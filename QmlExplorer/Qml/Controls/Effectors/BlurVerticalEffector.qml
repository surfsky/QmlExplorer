import QtQuick 2.0


// 竖条纹高斯模糊
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property variant source : img

    property real blurSize: 8.0
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
        c += texture2D(source, uv - vec2(0.0, 4.0*blurSize)) * 0.05;
        c += texture2D(source, uv - vec2(0.0, 3.0*blurSize)) * 0.09;
        c += texture2D(source, uv - vec2(0.0, 2.0*blurSize)) * 0.12;
        c += texture2D(source, uv - vec2(0.0, 1.0*blurSize)) * 0.15;
        c += texture2D(source, uv) * 0.18;
        c += texture2D(source, uv + vec2(0.0, 1.0*blurSize)) * 0.15;
        c += texture2D(source, uv + vec2(0.0, 2.0*blurSize)) * 0.12;
        c += texture2D(source, uv + vec2(0.0, 3.0*blurSize)) * 0.09;
        c += texture2D(source, uv + vec2(0.0, 4.0*blurSize)) * 0.05;
    } else {
        c = texture2D(source, qt_TexCoord0);
    }
    // First pass we don't apply opacity
    gl_FragColor = c;
}
        "
}
