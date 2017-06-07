import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/ColorPicker/"
import "../../Controls/AnglePicker"


/**
测试图片融合blend效果
*/
Flickable{
    width: 600
    height: 600
    contentWidth: width
    contentHeight: 2000

    Grid {
        anchors.fill: parent
        columns:4
        spacing: 10

        //-------------------------------------------------
        // raw images
        //-------------------------------------------------
        Image {
            id: bug
            source: "../images/bug.png"
        }
        Image {
            id: butterfly
            source: "../images/butterfly.png"
        }

        //-------------------------------------------------
        // blend
        //-------------------------------------------------
        Repeater{
            model: [
                'normal', 'addition', 'average', 'color', 'colorBurn', 'colorDodge', 'darken', 'darkerColor',
                'difference', 'divide', 'exclusion', 'hardlight', 'hue', 'lighten', 'lighterColor', 'lightness',
                'negation', 'multiply', 'saturation', 'screen', 'subtract', 'softLight'
            ]
            delegate: Column{
                spacing: 5
                Blend {source: bug; foregroundSource: butterfly; width:bug.width; height: bug.height; mode: modelData}
                Text {text: modelData; anchors.horizontalCenter: parent.horizontalCenter}
            }
        }
    }
}

