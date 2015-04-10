import QtQuick 2.0

Rectangle {
    width: 500
    height: 500

    Image{
        id: img
        source: "../images/bug.png"
        anchors.centerIn: parent
    }

    // 不知道什么效果，也不知道怎么配置参数
    ShaderEffect {
        id: shader
        anchors.fill:  parent

        property variant source : img
        property real dividerValue : 0.5;
        property real centerX : parent.width/2;
        property real centerY : parent.height/2;
        property real granularity: 200;   // 没用到？
        property real time: 10;           //
        property real weight: 100;        //


        fragmentShader: "
uniform float centerX;
uniform float centerY;
uniform float dividerValue;
uniform float granularity;
uniform float time;
uniform float weight;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec2 tc = qt_TexCoord0;
    vec2 center = vec2(centerX, centerY);
    const vec3 shock = vec3(10.0, 1.5, 0.1);
    if (uv.x < dividerValue) {
        float distance = distance(uv, center);
        if ((distance <= (time + shock.z)) &&
            (distance >= (time - shock.z))) {
            float diff = (distance - time);
            float powDiff = 1.0 - pow(abs(diff*shock.x), shock.y*weight);
            float diffTime = diff  * powDiff;
            vec2 diffUV = normalize(uv - center);
            tc += (diffUV * diffTime);
        }
    }
    gl_FragColor = qt_Opacity * texture2D(source, tc);
}
        "
    }
}
