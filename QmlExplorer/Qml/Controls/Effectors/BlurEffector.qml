import QtQuick 2.0

// 模糊效果
ShaderEffect {
    id: shader
    width:source.width;
    height:source.height
    property Item source
    property real dividerValue: 1.0

    fragmentShader: "
const float step_w = 0.0015625;
const float step_h = 0.0027778;
uniform sampler2D source;
uniform float dividerValue;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

vec3 blur()
{
    vec2 uv = qt_TexCoord0.xy;
    float y = uv.y < 0.4 ? uv.y : 1.0 - uv.y;
    float dist = 8.0 - 20.0 * y;
    vec3 acc = vec3(0.0, 0.0, 0.0);
    for (float y=-2.0; y<=2.0; ++y) {
        for (float x=-2.0; x<=2.0; ++x) {
            acc += texture2D(source, vec2(uv.x + dist * x * step_w, uv.y + 0.5 * dist * y * step_h)).rgb;
        }
    }
    return acc / 25.0;
}

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec3 col;
    if (uv.x > dividerValue || (uv.y >= 0.4 && uv.y <= 0.6))
        col = texture2D(source, uv).rgb;
    else
        col = blur();
    gl_FragColor = qt_Opacity * vec4(col, 1.0);
}
        "
}
