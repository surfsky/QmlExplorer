import QtQuick 2.0

// 虚光照效果(Vignette)，调暗图片边缘
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property variant source : img
    property real dividerValue: 1

    fragmentShader: "
uniform float dividerValue;
uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec4 orig = texture2D(source, uv);
    float cr = pow(0.1, 2.0);
    float pt = pow(uv.x - 0.5, 2.0) + pow(uv.y - 0.5, 2.0);
    float d = pt - cr;
    float cf = 1.0;
    if (d > 0.0)
        cf = 1.0 - 2.0 * d;
    vec3 col = cf * orig.rgb;
    if (uv.x < dividerValue)
        gl_FragColor = qt_Opacity * vec4(col, 1.0);
    else
        gl_FragColor = qt_Opacity * orig;
}
        "
}
