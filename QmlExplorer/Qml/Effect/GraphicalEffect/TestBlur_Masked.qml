import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"


/**
测试遮罩模糊（遮罩是个alpha渐变图）
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10


    // 原始图
    Image {
        id: img
        source: "../images/bug.png"
        visible: false;
    }

    // 遮罩图
    Rectangle {
        id: mask
        anchors.fill: img
        visible: false
        rotation: -90
        gradient: Gradient {
             GradientStop { position: 0.2; color: Qt.rgba(maskAlphaBeginSlider.value, maskAlphaBeginSlider.value, maskAlphaBeginSlider.value, maskAlphaBeginSlider.value) }
             GradientStop { position: 0.5; color: Qt.rgba(maskAlphaEndSlider.value, maskAlphaEndSlider.value, maskAlphaEndSlider.value, maskAlphaEndSlider.value) }
        }
    }

    // 遮罩模糊组件
    MaskedBlur {
        id: blur
        width: source.width
        height: source.height
        anchors.horizontalCenter: parent.horizontalCenter
        source: img
        maskSource: mask
        radius: sldRadius.value
        samples: sldSamples.value
        fast: swhFast.checked
        transparentBorder: swhTransparentBorder.checked
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

        Text{text:'fast'}
        Switch{id: swhFast; checked : false; }
        Item{width:1; height:1}

        Text{text:'transparentBorder'}
        Switch{id: swhTransparentBorder; checked : false; }
        Item{width:1; height:1}


        Text{text:'alphaStart'}
        Slider {id: maskAlphaBeginSlider; minimumValue: 0.0; maximumValue: 1.0; value: 0}
        Text{text: maskAlphaBeginSlider.value}

        Text{text:'alphaEnd'}
        Slider {id: maskAlphaEndSlider; minimumValue: 0.0; maximumValue: 1.0; value: 0.5}
        Text{text: maskAlphaEndSlider.value}
    }
}
