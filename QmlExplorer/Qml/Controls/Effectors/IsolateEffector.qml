import QtQuick 2.0


// 分离背景
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property variant source : img
    property real blurSize: 4.0
    property real dividerValue: 0.5
    property real targetHue: 0.5
    property real windowWidth : parent.width


    fragmentShader: "
uniform float targetHue;
uniform float windowWidth;
uniform float dividerValue;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void rgb2hsl(vec3 rgb, out float h, out float s, float l)
{
    float maxval = max(rgb.r, max(rgb.g, rgb.b));
    float minval = min(rgb.r, min(rgb.g, rgb.b));
    float delta = maxval - minval;
    l = (minval + maxval) / 2.0;
    s = 0.0;
    if (l > 0.0 && l < 1.0)
        s = delta / (l < 0.5 ? 2.0 * l : 2.0 - 2.0 * l);
    h = 0.0;
    if (delta > 0.0)
    {
        if (rgb.r == maxval && rgb.g != maxval)
            h += (rgb.g - rgb.b ) / delta;
        if (rgb.g == maxval && rgb.b != maxval)
            h += 2.0  + (rgb.b - rgb.r) / delta;
        if (rgb.b == maxval && rgb.r != maxval)
            h += 4.0 + (rgb.r - rgb.g) / delta;
        h *= 60.0;
    }
}

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec3 col = texture2D(source, uv).rgb;
    float h, s, l;
    rgb2hsl(col, h, s, l);
    float h2 = (h > targetHue) ? h - 360.0 : h + 360.0;
    float y = 0.3 * col.r + 0.59 * col.g + 0.11 * col.b;
    vec3 result;
    if (uv.x > dividerValue || (abs(h - targetHue) < windowWidth) || (abs(h2 - targetHue) < windowWidth))
        result = col;
    else
        result = vec3(y, y, y);
    gl_FragColor = qt_Opacity * vec4(result, 1.0);
}
        "
}
