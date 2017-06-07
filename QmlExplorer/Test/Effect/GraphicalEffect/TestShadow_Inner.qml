import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/ColorPicker/"

Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    InnerShadow {
        width: source.width
        height: source.height
        anchors.horizontalCenter: parent.horizontalCenter
        radius: sldRadius.value
        samples: sldSamples.value
        horizontalOffset: sldOffsetH.value
        verticalOffset: sldOffsetV.value
        color: pkrColor.color
        source: Image {source: "../images/butterfly.png"}
        fast: swhFast.checked
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
        Slider {id: sldRadius; minimumValue: 1.0; maximumValue: 30.0; stepSize: 1.0; value: 8}
        Text{text: sldRadius.value}

        Text{text:'samples'}
        Slider {id: sldSamples; minimumValue: 1.0; maximumValue: 32.0; stepSize: 1.0; value: 16}
        Text{text: sldSamples.value}

        Text{text:'offset-h'}
        Slider {id: sldOffsetH; minimumValue: -10; maximumValue: 10; stepSize: 1.0; value: -3}
        Text{text: sldOffsetH.value}

        Text{text:'offset-v'}
        Slider {id: sldOffsetV; minimumValue: -10; maximumValue: 10; stepSize: 1.0; value: -3}
        Text{text: sldOffsetV.value}

        Text{text:'color'}
        ColorPicker {id: pkrColor; color: '#b0000000'; }
        Item{width:1; height:1}

        Text{text:'fast'}
        Switch{id: swhFast; checked : false; }
        Item{width:1; height:1}
    }
}
