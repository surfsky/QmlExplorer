import QtQuick 2.0


/**
将Shader应用到任意Item（设置其layer.effect属性）
*/
Column {
    width: 600
    height: 600
    spacing: 10

    // layer.enabled逻辑
    Item {
        id: layered
        width: 100
        height: 100
        opacity: 0.5
        layer.enabled: true    // 将item以及子元素作为整体渲染，子类不继承opacity属性
        Rectangle { width: 80; height: 80; border.width: 1 }
        Rectangle { x: 20; y: 20; width: 80; height: 80; border.width: 1 }
    }

    // 绘制灰度图片
    // 给Item应用ShaderEffect
    Image {
        width: 80;
        height: width
        source: '../images/bug.png'
        layer.enabled: true
        layer.effect: ShaderEffect {
            fragmentShader: "
                uniform lowp sampler2D source; // this item
                uniform lowp float qt_Opacity; // inherited opacity of this item
                varying highp vec2 qt_TexCoord0;
                void main() {
                    lowp vec4 p = texture2D(source, qt_TexCoord0);
                    lowp float g = dot(p.xyz, vec3(0.344, 0.5, 0.156));
                    gl_FragColor = vec4(g, g, g, p.a) * qt_Opacity;
                }"
        }
    }

    // 绘制渐变文字
    Text {
        id: textItem
        font.pixelSize: 48
        font.bold: true
        text: "Gradient Text"
        layer.enabled: true
        layer.samplerName: "maskSource"  // This item should be used as the 'mask'
        layer.effect: ShaderEffect {
            property var colorSource: gradientRect;
            fragmentShader: "
               uniform lowp sampler2D colorSource;
               uniform lowp sampler2D maskSource;
               uniform lowp float qt_Opacity;
               varying highp vec2 qt_TexCoord0;
               void main() {
                   gl_FragColor =
                         texture2D(colorSource, qt_TexCoord0)
                       * texture2D(maskSource, qt_TexCoord0).a
                       * qt_Opacity;
               }
               "
        }
    }
    Rectangle {
        id: gradientRect;
        width: 10
        height: 10
        gradient: Gradient {
            GradientStop { position: 0; color: "white" }
            GradientStop { position: 1; color: "steelblue" }
        }
        visible: false; // should not be visible on screen.
        layer.enabled: true;
        layer.smooth: true
    }
}

