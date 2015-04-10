import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2


/**
去饱和度
HueSaturation 的简化版本
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

    Desaturate {
        source: bug
        desaturation: sldDesaturation.value

        anchors.horizontalCenter: parent.horizontalCenter
        width: source.width
        height: source.height
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


        Text{text:'desaturation'}
        Slider {id: sldDesaturation; minimumValue: 0; maximumValue: 1.0; stepSize: 0.1; value: 0.5}
        Text{text: sldDesaturation.value}
    }
}
