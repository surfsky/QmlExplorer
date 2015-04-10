import QtQuick 2.0

/*
卷书效果（从右上角到左下角，卷成圆柱形）
用手指交互的话，调整curlExtent的值即可（0-1）
好复杂，有空改成右到左（失败）
*/
ShaderEffect {
    id: shader
    width: source.width
    height: source.height

    // 卷曲效果控制属性
    property Item source;                        // 源图像
    property color bgColor: 'transparent'        // 背景色彩
    property real curlExtent: 0.5;               // 当前卷曲程度(0-1)
    property real minAmount: -0.16;              // 从什么时候开始卷。-0.16
    property real maxAmount: 1.3;                // 卷到什么时候结束。1.3

    // 动画
    property bool animationRunning : true;
    property int animationDuration : 1000;
    NumberAnimation{
        target: shader
        properties: 'curlExtent'
        from: 0
        to: 1.0
        loops: Animation.Infinite
        duration: animationDuration
        running: animationRunning
    }

    fragmentShader: "
uniform sampler2D source;                        // 源图像
uniform vec4 bgColor;                            // 背景色彩
uniform float curlExtent;                        // 当前卷曲程度
uniform float minAmount;                         // 从什么时候开始卷。-0.16
uniform float maxAmount;                         // 卷到什么时候结束。1.3

uniform float qt_Opacity;                        // qt不透明度
varying vec2 qt_TexCoord0;                       // qt纹理坐标

const float PI = 3.141592653589793;              // PI
const float scale = 512.0;                       // 抗锯齿计算参数
const float sharpness = 3.0;                     // 抗锯齿计算参数（锐利程度）


// 整个图像绕在一个圆柱体上，绕成360度
float amount = curlExtent * (maxAmount - minAmount) + minAmount;  // 当前圆柱中点
float cylinderCenter = amount;                   // 圆柱体中心点
float cylinderAngle = 2.0 * PI * amount;         // 圆柱体卷曲度数
const float cylinderRadius = 1.0 / PI / 2.0;     // 圆柱体半径(1/2PI)

// 获取变形后某个点的位置
vec3 hitPoint(float hitAngle, float yc, vec3 point, mat3 rrotation)
{
    point.y = hitAngle / (2.0 * PI);
    return rrotation * point;
}

// 抗锯齿（已知两个点的色彩和当前点距离，求当前点的模拟色彩）
vec4 antiAlias(vec4 color1, vec4 color2, float distance)
{
    distance *= scale;
    if (distance < 0.0) return color2;
    if (distance > 2.0) return color1;
    float dd = pow(1.0 - distance / 2.0, sharpness);
    return ((color2 - color1) * dd) + color1;
}

// 某个点到最近的边的距离
float distanceToEdge(vec3 point)
{
    float dx = abs(point.x > 0.5 ? 1.0 - point.x : point.x);  // 到最近的边的X距离
    float dy = abs(point.y > 0.5 ? 1.0 - point.y : point.y);  // 到最近的边的Y距离
    if (point.x < 0.0) dx = -point.x;
    if (point.x > 1.0) dx = point.x - 1.0;
    if (point.y < 0.0) dy = -point.y;
    if (point.y > 1.0) dy = point.y - 1.0;
    if ((point.x < 0.0 || point.x > 1.0) && (point.y < 0.0 || point.y > 1.0)) return sqrt(dx * dx + dy * dy);
    return min(dx, dy);
}

// ?
vec4 seeThrough(float yc, vec2 p, mat3 rotation, mat3 rrotation)
{
    float hitAngle = PI - (acos(yc / cylinderRadius) - cylinderAngle);
    vec3 point = hitPoint(hitAngle, yc, rotation * vec3(p, 1.0), rrotation);
    // 返回背景色
    if (yc <= 0.0 && (point.x < 0.0 || point.y < 0.0 || point.x > 1.0 || point.y > 1.0))
        return bgColor;
    // 返回原图前景
    if (yc > 0.0)
        return texture2D(source, p);
    // 返回卷轴区域中的色彩
    vec4 color = texture2D(source, point.xy);
    vec4 tcolor = vec4(0.0);
    return antiAlias(color, tcolor, distanceToEdge(point));
}

// ?
vec4 seeThroughWithShadow(float yc, vec2 p, vec3 point, mat3 rotation, mat3 rrotation)
{
    float shadow = distanceToEdge(point) * 30.0;
    shadow = (1.0 - shadow) / 3.0;
    if (shadow < 0.0)
        shadow = 0.0;
    else
        shadow *= amount;
    vec4 shadowColor = seeThrough(yc, p, rotation, rrotation);
    shadowColor.r -= shadow;
    shadowColor.g -= shadow;
    shadowColor.b -= shadow;
    return shadowColor;
}

// 获取卷筒背面某个点对应的色彩（灰度）
vec4 backside(float yc, vec3 point)
{
    vec4 color = texture2D(source, point.xy);
    float gray = (color.r + color.b + color.g) / 15.0;
    gray += (8.0 / 10.0) * (pow(1.0 - abs(yc / cylinderRadius), 2.0 / 10.0) / 2.0 + (5.0 / 10.0));
    color.rgb = vec3(gray);
    return color;
}

// 主入口
void main(void)
{
    const float angle = 30.0 * PI / 180.0;    // 翻页角度？大于45度算法就有问题了
    float c = cos(-angle);
    float s = sin(-angle);
    mat3 rotation = mat3(
        c, s, 0,
        -s, c, 0,
        0.12, 0.258, 1
    );
    c = cos(angle);
    s = sin(angle);
    mat3 rrotation = mat3(
        c, s, 0,
        -s, c, 0,
        0.15, -0.5, 1
    );
    vec3 point = rotation * vec3(qt_TexCoord0, 1.0);
    float yc = point.y - cylinderCenter;
    vec4 color = vec4(1.0, 0.0, 0.0, 1.0);
    if (yc < -cylinderRadius) {
        // 背景色
        color = bgColor;
    } else if (yc > cylinderRadius) {
        // 原图
        color = texture2D(source, qt_TexCoord0);
    } else {
        // 在滚动区域
        float hitAngle = (acos(yc / cylinderRadius) + cylinderAngle) - PI;
        float hitAngleMod = mod(hitAngle, 2.0 * PI);
        if ((hitAngleMod > PI && amount < 0.5) || (hitAngleMod > PI/2.0 && amount < 0.0)) {
            // 正面扭曲
            color = seeThrough(yc, qt_TexCoord0, rotation, rrotation);
        } else {
            point = hitPoint(hitAngle, yc, point, rrotation);
            // 正面扭曲并带阴影
            if (point.x < 0.0 || point.y < 0.0 || point.x > 1.0 || point.y > 1.0) {
                color = seeThroughWithShadow(yc, qt_TexCoord0, point, rotation, rrotation);
            }
            // 背面扭曲灰度图
            else {
                color = backside(yc, point);
                vec4 otherColor;
                if (yc < 0.0) {
                    float shado = 1.0 - (sqrt(pow(point.x - 0.5, 2.0) + pow(point.y - 0.5, 2.0)) / 0.71);
                    shado *= pow(-yc / cylinderRadius, 3.0);
                    shado *= 0.5;
                    otherColor = vec4(0.0, 0.0, 0.0, shado);
                } else {
                    otherColor = texture2D(source, qt_TexCoord0);
                }
                color = antiAlias(color, otherColor, cylinderRadius - abs(yc));

                // This second antialiasing step causes the shader to fail to render, on
                // Symbian devices (tested so far using IVE3.5).  Running out of scratch
                // memory?
            }
        }
    }
    gl_FragColor = qt_Opacity * color;
}
        "
}
