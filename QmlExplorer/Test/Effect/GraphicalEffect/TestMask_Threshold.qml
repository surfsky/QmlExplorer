import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2



/**
测试阀值遮罩（更复杂的OpacityMask，可控阀值）
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10



    Image {
        id: img
        source: "../images/bug.png"
        visible: false;
    }

    LinearGradient {
        id: gradient
        anchors.fill: img
        gradient: Gradient {
            GradientStop { position: 0.1; color: "#ffffffff" }
            GradientStop { position: 0.8; color: "#00ffffff" }
        }
        start: Qt.point(0, 0)
        end: Qt.point(300, 0)
        visible: false;
    }

    ThresholdMask {
        id: blur
        width: source.width
        height: source.height
        anchors.horizontalCenter: parent.horizontalCenter
        source: img
        maskSource: gradient
        threshold: sldThreshold.value
        spread: sldSpread.value
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


        Text{text:'threshold'}
        Slider {id: sldThreshold; minimumValue: 0.1; maximumValue: 1.0; stepSize: 0.1; value: 0.3}
        Text{text: sldThreshold.value}

        Text{text:'spread'}
        Slider {id: sldSpread; minimumValue: 0.1; maximumValue: 1.0; stepSize: 0.1; value: 0.5}
        Text{text: sldSpread.value}
    }
}
