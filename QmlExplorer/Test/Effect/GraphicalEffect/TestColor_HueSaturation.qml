import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"


/**
色相饱和度调整
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    Image {
        id: bug
        source: "../images/bug.png"
        smooth: true
        visible: false
    }

    HueSaturation {
        source: bug
        hue: sldHue.value
        saturation: sldSaturation.value
        lightness: sldLight.value
        width: source.width
        height: source.height
        anchors.horizontalCenter: parent.horizontalCenter
    }

    //----------------------------------------
    // 控制区
    //----------------------------------------
    Grid{
        width: 300
        height: 300
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 3
        spacing: 10


        Text{text:'hue'}
        Slider {id: sldHue; minimumValue: -1; maximumValue: 1.0; stepSize: 0.1; value: 0.2}
        Text{text: sldHue.value}

        Text{text:'saturation'}
        Slider {id: sldSaturation; minimumValue: -1; maximumValue: 1.0; stepSize: 0.1; value: 0.7}
        Text{text: sldSaturation.value}

        Text{text:'lightness'}
        Slider {id: sldLight; minimumValue: -1; maximumValue: 1.0; stepSize: 0.1; value: 0}
        Text{text: sldLight.value}
    }
}
