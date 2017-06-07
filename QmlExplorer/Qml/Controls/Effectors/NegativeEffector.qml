import QtQuick 2.0

// 底片效果
ShaderEffect {
    width: source.width
    height: source.height
    property Item source

    fragmentShader: "
       uniform sampler2D source;      // 外部传递进来的图片（常量、类型sample2D）
       uniform float qt_Opacity;      // 不透明度（常量，类型float）
       varying vec2 qt_TexCoord0;     // 当前点坐标（变量、类型vec2）
       void main() {
           vec4 p = texture2D(source, qt_TexCoord0);       // 当前点色彩值
           gl_FragColor = vec4(1-p.r, 1-p.g, 1-p.b, p.a) * qt_Opacity;
       }"
}
