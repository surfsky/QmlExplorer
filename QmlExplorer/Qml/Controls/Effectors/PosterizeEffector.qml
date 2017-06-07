import QtQuick 2.0


// 调色效果（posterize）：减少色彩数目
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property variant source : img
    property real dividerValue: 0.5
    property real gamma : 2
    property real numColors : 10

    fragmentShader: "
uniform float dividerValue;
uniform float gamma;
uniform float numColors;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec4 c = vec4(0.0);
    if (uv.x < dividerValue) {
        vec3 x = texture2D(source, uv).rgb;
        x = pow(x, vec3(gamma, gamma, gamma));
        x = x * numColors;
        x = floor(x);
        x = x / numColors;
        x = pow(x, vec3(1.0/gamma));
        c = vec4(x, 1.0);
    } else {
        c = texture2D(source, uv);
    }
    gl_FragColor = qt_Opacity * c;
}
        "
}
