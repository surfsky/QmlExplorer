import QtQuick 2.0


// 水泊效果（不太清楚参数）
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property Item source
    property real dividerValue: 1
    property real targetWidth: source.width;
    property real targetHeight: source.height;
    property real time : 6000;       //
    property real amplitude : 100;   // 振幅
    property real n : 10;            // 个数
    property real pixDens : 500;     //


    fragmentShader: "
uniform float dividerValue;
uniform float targetWidth;
uniform float targetHeight;
uniform float time;
uniform float amplitude;
uniform float n;
uniform float pixDens;

uniform sampler2D source;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

const float PI = 3.1415926535;
const int ITER = 7;
const float RATE = 0.1;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    vec2 tc = uv;
    vec2 p = vec2(-1.0 + 2.0 * (gl_FragCoord.x - (pixDens * 14.0)) / targetWidth, -(-1.0 + 2.0 * (gl_FragCoord.y - (pixDens * 29.0)) / targetHeight));
    float diffx = 0.0;
    float diffy = 0.0;
    vec4 col;
    if (uv.x < dividerValue) {
        for (int i=0; i<ITER; ++i) {
            float theta = float(i) * PI / float(ITER);
            vec2 r = vec2(cos(theta) * p.x + sin(theta) * p.y, -1.0 * sin(theta) * p.x + cos(theta) * p.y);
            float diff = (sin(2.0 * PI * n * (r.y + time * RATE)) + 1.0) / 2.0;
            diffx += diff * sin(theta);
            diffy += diff * cos(theta);
        }
        tc = 0.5*(vec2(1.0,1.0) + p) + amplitude * vec2(diffx, diffy);
    }
    gl_FragColor = qt_Opacity * texture2D(source, tc);
}
        "


    NumberAnimation{
        target: shader
        properties: 'amplitude'
        from: 0
        to: 1000
        duration: 5000
        loops: Animation.Infinite
        running: true
    }
}
