import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"



/**
测试发光效果
和drop shadow很相似
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    Rectangle {
        width: 300
        height: 300
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: butterfly
            source: "../images/butterfly.PNG"
            smooth: true
            visible: false
        }
        Glow {
            radius: sldRadius.value
            samples: sldSamples.value
            color: pkrColor.color
            spread: sldSpread.value
            fast: swhFast.checked
            transparentBorder: swhTransparentBorder.checked

            source: butterfly
            width: source.width
            height: source.height
            anchors.horizontalCenter: parent.horizontalCenter
        }
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


        Text{text:'radius'}
        Slider {id: sldRadius; minimumValue: 1.0; maximumValue: 30.0; stepSize: 1.0; value: 8}
        Text{text: sldRadius.value}

        Text{text:'samples'}
        Slider {id: sldSamples; minimumValue: 1.0; maximumValue: 32.0; stepSize: 1.0; value: 24}
        Text{text: sldSamples.value}

        Text{text:'color'}
        ColorPicker {id: pkrColor; color: 'white'; }
        Item{width:1; height:1}

        Text{text:'spread'}
        Slider {id: sldSpread; minimumValue: 0.1; maximumValue: 1.0; stepSize: 0.1; value: 0.2}
        Text{text: sldSpread.value}

        Text{text:'fast'}
        Switch{id: swhFast; checked : false; }
        Item{width:1; height:1}

        Text{text:'transparentBorder'}
        Switch{id: swhTransparentBorder; checked : false; }
        Item{width:1; height:1}
    }
}
