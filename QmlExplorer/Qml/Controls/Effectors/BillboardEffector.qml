import QtQuick 2.0


// 广告牌效果Billboard
ShaderEffect {
    id: shader
    width: source.width
    height: source.height
    property Item source;

    // 封装为ShaderEffectSource，这样任何Item都可以作为数据源
    //property var src : sourceProxy.output;
    //SourceProxy {id: sourceProxy; input: source}
    property var src : ShaderEffectSource{sourceItem : source; hideSource: false}

    // Shader变量
    property real blurSize: 4.0
    property real dividerValue: 1
    property real grid: 0.3
    property real step_x: 0.2
    property real step_y: 0.3


    fragmentShader: "
uniform float grid;
uniform float dividerValue;
uniform float step_x;
uniform float step_y;

uniform sampler2D src;
uniform lowp float qt_Opacity;
varying vec2 qt_TexCoord0;

void main()
{
    vec2 uv = qt_TexCoord0.xy;
    float offx = floor(uv.x  / (grid * step_x));
    float offy = floor(uv.y  / (grid * step_y));
    vec3 res = texture2D(src, vec2(offx * grid * step_x , offy * grid * step_y)).rgb;
    vec2 prc = fract(uv / vec2(grid * step_x, grid * step_y));
    vec2 pw = pow(abs(prc - 0.5), vec2(2.0));
    float  rs = pow(0.45, 2.0);
    float gr = smoothstep(rs - 0.1, rs + 0.1, pw.x + pw.y);
    float y = (res.r + res.g + res.b) / 3.0;
    vec3 ra = res / y;
    float ls = 0.3;
    float lb = ceil(y / ls);
    float lf = ls * lb + 0.3;
    res = lf * res;
    vec3 col = mix(res, vec3(0.1, 0.1, 0.1), gr);
    if (uv.x < dividerValue)
        gl_FragColor = qt_Opacity * vec4(col, 1.0);
    else
        gl_FragColor = qt_Opacity * texture2D(src, uv);
}
        "

    property bool animationRunning : true;
    property int animationDuration : 1000;
    NumberAnimation{
        target: shader
        properties: 'grid'
        from: 0
        to: 1.0
        loops: Animation.Infinite

        running: animationRunning
        duration: animationDuration;
    }
}

