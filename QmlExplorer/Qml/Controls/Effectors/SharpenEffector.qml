import QtQuick 2.0

// 边缘锐化
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property Item source
    property real dividerValue: 1
    property real amount: 10


    fragmentShader: "
uniform float dividerValue;
uniform float amount;
const float step_w = 0.0015625;
const float step_h = 0.0027778;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

vec3 sharpen(vec3 t1, vec3 t2, vec3 t3, vec3 t4, vec3 t5, vec3 t6, vec3 t7, vec3 t8, vec3 t9)
{
    return -t1 - t2 - t3 - t4 + amount * t5 - t6 - t7 - t8 - t9;
}

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec3 t1 = texture2D(source, vec2(uv.x - step_w, uv.y - step_h)).rgb;
    vec3 t2 = texture2D(source, vec2(uv.x, uv.y - step_h)).rgb;
    vec3 t3 = texture2D(source, vec2(uv.x + step_w, uv.y - step_h)).rgb;
    vec3 t4 = texture2D(source, vec2(uv.x - step_w, uv.y)).rgb;
    vec3 t5 = texture2D(source, uv).rgb;
    vec3 t6 = texture2D(source, vec2(uv.x + step_w, uv.y)).rgb;
    vec3 t7 = texture2D(source, vec2(uv.x - step_w, uv.y + step_h)).rgb;
    vec3 t8 = texture2D(source, vec2(uv.x, uv.y + step_h)).rgb;
    vec3 t9 = texture2D(source, vec2(uv.x + step_w, uv.y + step_h)).rgb;
    vec3 col = sharpen(t1, t2, t3, t4, t5, t6, t7, t8, t9);
    if (uv.x < dividerValue)
        gl_FragColor = qt_Opacity * vec4(col, 1.0);
    else
        gl_FragColor = qt_Opacity * texture2D(source, uv);
}
        "
}
