import QtQuick 2.0

Rectangle {
    width: 500
    height: 500

    Image{
        id: img
        source: "../images/butterfly.png"
        anchors.centerIn: parent
        visible: false
    }


    // 红椿(toon)?参数不知道怎么设置
    ShaderEffect {
        id: shader
        anchors.fill:  parent

        property variant source : img
        property real dividerValue: 0.5
        property real threshold : 1;
        property real resS : 0.5;
        property real resT : 0.5;
        property real magTol : 50;
        property real quantize : 10;

        fragmentShader: "
uniform float dividerValue;
uniform float threshold;
uniform float resS;
uniform float resT;
uniform float magTol;
uniform float quantize;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec4 color = vec4(1.0, 0.0, 0.0, 1.1);
    vec2 uv = qt_TexCoord0.xy;
    if (uv.x < dividerValue) {
        vec2 st = qt_TexCoord0.st;
        vec3 rgb = texture2D(source, st).rgb;
        vec2 stp0 = vec2(1.0/resS,  0.0);
        vec2 st0p = vec2(0.0     ,  1.0/resT);
        vec2 stpp = vec2(1.0/resS,  1.0/resT);
        vec2 stpm = vec2(1.0/resS, -1.0/resT);
        float i00 =   dot( texture2D(source, st).rgb, vec3(0.2125,0.7154,0.0721));
        float im1m1 = dot( texture2D(source, st-stpp).rgb, vec3(0.2125,0.7154,0.0721));
        float ip1p1 = dot( texture2D(source, st+stpp).rgb, vec3(0.2125,0.7154,0.0721));
        float im1p1 = dot( texture2D(source, st-stpm).rgb, vec3(0.2125,0.7154,0.0721));
        float ip1m1 = dot( texture2D(source, st+stpm).rgb, vec3(0.2125,0.7154,0.0721));
        float im10 =  dot( texture2D(source, st-stp0).rgb, vec3(0.2125,0.7154,0.0721));
        float ip10 =  dot( texture2D(source, st+stp0).rgb, vec3(0.2125,0.7154,0.0721));
        float i0m1 =  dot( texture2D(source, st-st0p).rgb, vec3(0.2125,0.7154,0.0721));
        float i0p1 =  dot( texture2D(source, st+st0p).rgb, vec3(0.2125,0.7154,0.0721));
        float h = -1.*im1p1 - 2.*i0p1 - 1.*ip1p1  +  1.*im1m1 + 2.*i0m1 + 1.*ip1m1;
        float v = -1.*im1m1 - 2.*im10 - 1.*im1p1  +  1.*ip1m1 + 2.*ip10 + 1.*ip1p1;
        float mag = sqrt(h*h + v*v);
        if (mag > magTol) {
            color = vec4(0.0, 0.0, 0.0, 1.0);
        }
        else {
            rgb.rgb *= quantize;
            rgb.rgb += vec3(0.5, 0.5, 0.5);
            ivec3 irgb = ivec3(rgb.rgb);
            rgb.rgb = vec3(irgb) / quantize;
            color = vec4(rgb, 1.0);
        }
    } else {
        color = texture2D(source, uv);
    }
    gl_FragColor = qt_Opacity * color;
}
        "
    }
}
