import QtQuick 2.0


// 放大镜效果（参数还不太清楚）
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property variant source : img
    property real targetWidth : parent.width
    property real targetHeight: parent.height
    property real posX : parent.width/2-radius
    property real posY : parent.height/2-radius
    property real radius : 100            // 放大镜半径
    property real pixDens : 5             // 像素密度？
    property real diffractionIndex : 1    // 衍射？？


    fragmentShader: "
uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;
uniform float radius;
uniform float diffractionIndex;
uniform float targetWidth;
uniform float targetHeight;
uniform float posX;
uniform float posY;
uniform float pixDens;

void main()
{
    vec2 tc = qt_TexCoord0;
    vec2 center = vec2(posX, posY);
    vec2 xy = gl_FragCoord.xy - center.xy;
    xy.x -= (pixDens * 14.0);
    xy.y -= (pixDens * 29.0);
    float r = sqrt(xy.x * xy.x + xy.y * xy.y);
    if (r < radius) {
        float h = diffractionIndex * 0.5 * radius;
        vec2 new_xy = r < radius ? xy * (radius - h) / sqrt(radius * radius - r * r) : xy;
        vec2 targetSize = vec2(targetWidth, targetHeight);
        tc = (new_xy + center) / targetSize;
        tc.y = 1.0 - tc.y;
    }
    gl_FragColor = qt_Opacity * texture2D(source, tc);
}
        "
}
