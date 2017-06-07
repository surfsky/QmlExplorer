import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/ColorPicker/"

/**
测试FastBlur
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    GaussianBlur {
        width: source.width;
        height: source.height
        source: Image {source: "../images/bug.png"}
        radius: sldRadius.value
        samples: sldSamples.value
        deviation: sldDeviation.value
        transparentBorder: swhTransparentBorder.checked
        anchors.horizontalCenter: parent.horizontalCenter
    }

    //----------------------------------------
    // 控制区
    //----------------------------------------
    Grid{
        width: 400
        height: 300
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 3
        spacing: 10

        Text{text:'radius'}
        Slider {id: sldRadius; minimumValue: 1.0; maximumValue: 64.0; stepSize: 1.0; value: 8}
        Text{text: sldRadius.value}

        Text{text:'samples'}
        Slider {id: sldSamples; minimumValue: 1.0; maximumValue: 32.0; stepSize: 1.0; value: 16}
        Text{text: sldSamples.value}

        Text{text:'deviation'}
        Slider {id: sldDeviation; minimumValue: 1.0; maximumValue: 32.0; stepSize: 1.0; value: 4}
        Text{text: sldDeviation.value}

        Text{text:'transparentBorder'}
        Switch{id: swhTransparentBorder; checked : false}
        Item{width:1; height:1}
    }
}
