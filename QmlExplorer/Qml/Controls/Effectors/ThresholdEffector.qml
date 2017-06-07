import QtQuick 2.0


/**
黑白阀值滤镜
*/
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property variant source : img    // 处理源
    property real dividerValue: 1.0  // 处理区域比例
    property real threshold: 0.5     // 阀值


    fragmentShader: "
uniform float threshold;
uniform float dividerValue;

uniform sampler2D source;
uniform float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec4 orig = texture2D(source, uv);
    vec3 col = orig.rgb;
    float y = 0.3 *col.r + 0.59 * col.g + 0.11 * col.b;  // 灰度值
    y = y < threshold ? 0.0 : 1.0;
    if (uv.x < dividerValue)
        gl_FragColor = qt_Opacity * vec4(y, y, y, 1.0);
    else
        gl_FragColor = qt_Opacity * orig;
}
        "
}
