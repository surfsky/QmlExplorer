import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"


/**
测试方向模糊
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    DirectionalBlur {
        source: Image {source: "../images/bug.png"}
        width: source.width
        height: source.height
        anchors.horizontalCenter: parent.horizontalCenter
        samples: sldSamples.value
        angle: sldAngle.value-90    // 径向模糊角度范围-180~180
        length: sldLength.value
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

        Text{text:'samples'}
        Slider {id: sldSamples; minimumValue: 1.0; maximumValue: 32.0; stepSize: 1.0; value: 24}
        Text{text: sldSamples.value}

        Text{text:'angle'}
        AnglePicker {id: sldAngle; value: 90; width:40; height:40}
        Text{text: Math.round(sldAngle.value)}


        Text{text:'length'}
        Slider {id: sldLength; minimumValue: 0; maximumValue: 100; stepSize: 1.0; value: 32}
        Text{text: sldLength.value}
    }
}
