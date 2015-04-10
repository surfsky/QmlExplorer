import QtQuick 2.0


// 像素化（马赛克）
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property variant source : img
    property real dividerValue: 1
    property real granularity : 8;  // 马赛克大小
    property real targetWidth : img.width;
    property real targetHeight: img.height;


    fragmentShader: "
uniform float dividerValue;
uniform float granularity;
uniform float targetWidth;
uniform float targetHeight;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec2 tc = qt_TexCoord0;
    if (uv.x < dividerValue && granularity > 0.0) {
        float dx = granularity / targetWidth;
        float dy = granularity / targetHeight;
        tc = vec2(dx*(floor(uv.x/dx) + 0.5),
                  dy*(floor(uv.y/dy) + 0.5));
    }
    gl_FragColor = qt_Opacity * texture2D(source, tc);
}
        "
}
