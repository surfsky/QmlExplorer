import QtQuick 2.0

// 色彩通道
ShaderEffect {
    id: effect4
    width: source.width
    height: source.height
    property Item source
    property real redChannel: 0.3
    property real greenChannel: 1.0
    property real blueChannel: 1.0
    property real alphaChannel: 1.0



    fragmentShader: "
       uniform sampler2D source;      // 外部传递进来的图片（常量、类型sample2D）
       uniform float qt_Opacity;      // 不透明度（常量，类型float）
       varying vec2 qt_TexCoord0;     // 当前点坐标（变量、类型vec2）
       uniform float redChannel;      // 红色通道比例（常量、类型float）
       uniform float greenChannel;    // 绿色通道比例（常量、类型float）
       uniform float blueChannel;     // 蓝色通道比例（常量、类型float）
       uniform float alphaChannel;    // 透明度通道比例（常量、类型float）
       void main() {
           vec4 p = texture2D(source, qt_TexCoord0);       // 当前点色彩值
           gl_FragColor = p * vec4(redChannel, greenChannel, blueChannel, alphaChannel) * qt_Opacity;
       }"


    // 将动画作用于redChannel变量，实现动画效果
    property bool animationRunning : true;
    property int animationDuration : 1000;
    NumberAnimation on redChannel {
        from: 0.0; to: 1.0; loops: Animation.Infinite;
        running: animationRunning
        duration: animationDuration;
    }
}
