import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"



/**
上色
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

    Colorize {
        source: bug
        hue: pkrHue.hsl.h
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
        ColorPalettePicker{id: pkrHue; paletteSize : Qt.size(256, 1); height:20; width:200}
        Text{text: pkrHue.hsl.h}

        Text{text:'saturation'}
        Slider {id: sldSaturation; minimumValue: 0; maximumValue: 1.0; stepSize: 0.1; value: 0.8}
        Text{text: sldSaturation.value}

        Text{text:'lightness'}
        Slider {id: sldLight; minimumValue: -1; maximumValue: 1.0; stepSize: 0.1; value: 0.5}
        Text{text: sldLight.value}

    }
}
