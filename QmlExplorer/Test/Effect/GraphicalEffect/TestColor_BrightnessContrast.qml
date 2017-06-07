import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"

/**
调整亮度对比度
有空改成用曲线来调整
*/
Column {
    width: 800
    height: 600
    spacing: 10

    Image {
        id: bug
        source: "../images/bug.png"
        smooth: true
        visible: false
    }

    BrightnessContrast {
        source: bug
        brightness: sldBright.value
        contrast: sldContrast.value
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

        Text{text:'bright'}
        Slider {id: sldBright; minimumValue: -1; maximumValue: 1; stepSize: 0.1; value: 0.5}
        Text{text: sldBright.value}

        Text{text:'contrast'}
        Slider {id: sldContrast; minimumValue: -1; maximumValue: 1; stepSize: 0.1; value: 0.5}
        Text{text: sldContrast.value}
    }
}
