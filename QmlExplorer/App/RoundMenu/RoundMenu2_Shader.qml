import QtQuick 2.3
import QtGraphicalEffects 1.0


/**
方案2：
    用OpacityShader来构建不规则图像外观
    子控件出界问题未解决
*/
Item {
    width: 600
    height: 300

    Rectangle {
        id: mask
        anchors.centerIn: parent
        width: 400
        height: 400
        radius: height/2
        layer.enabled: true
        visible: false;
    }

    Image {
        id: image
        anchors.fill: mask
        source: "bug.png"
        visible: false;
    }

    // 等效于 OpacityMask
    ShaderEffect {
        id: maskEffect
        anchors.fill: mask
        property variant sourceTexture: image
        property variant maskTexture: mask
        fragmentShader: "
           uniform lowp sampler2D sourceTexture;
           uniform lowp sampler2D maskTexture;
           varying highp vec2 qt_TexCoord0;
           void main (void)
           {
               vec4 c = texture2D(sourceTexture, qt_TexCoord0);
               vec4 m = texture2D(maskTexture, qt_TexCoord0);
               gl_FragColor = vec4(c.rgb, m.a);
           }
       "
    }
}
