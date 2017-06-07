import QtQuick 2.0

/**
倒影效果。
/qml
    Image{
        id: img
        source: "../Images/qml.png"
        width: 30;
        height:30
    }
    ReflectEffector{
        source: img
    }
*/
ShaderEffect {
    width: source.width
    height: source.height;
    anchors.top: source.bottom
    anchors.left: source.left

    property variant source;
    property size sourceSize: Qt.size(0.5/source.width, 0.5/source.height);

    fragmentShader: "
        varying highp vec2 qt_TexCoord0;
        uniform lowp sampler2D source;
        uniform lowp vec2 sourceSize;
        uniform lowp float qt_Opacity;

        void main() {
            lowp vec2 tc = qt_TexCoord0 * vec2(1, -1) + vec2(0, 1);
            lowp vec4 col = 0.25 * (texture2D(source, tc + sourceSize)
                            + texture2D(source, tc - sourceSize)
                            + texture2D(source, tc + sourceSize * vec2(1, -1))
                            + texture2D(source, tc + sourceSize * vec2(-1, 1))
                           );
            gl_FragColor = col * qt_Opacity * (1.0 - qt_TexCoord0.y) * 0.2;
        }"
}
