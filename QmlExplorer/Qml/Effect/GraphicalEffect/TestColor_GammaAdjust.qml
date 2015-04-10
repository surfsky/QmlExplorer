import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2


/**
gamma 通道校正
GammaAdjust is applied to each pixel according to the curve which is pre-defined as a power-law expression, where the property gamma is used as the reciprocal scaling exponent.
只有一个控制点的曲线校正，只作用于亮度?
看帮助吧
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

    GammaAdjust {
        source: bug
        gamma: sldGamma.value

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


        Text{text:'gamma'}
        Slider {id: sldGamma; minimumValue: 0; maximumValue: 30.0; stepSize: 0.1; value:0.4}
        Text{text: sldGamma.value}

    }
}
