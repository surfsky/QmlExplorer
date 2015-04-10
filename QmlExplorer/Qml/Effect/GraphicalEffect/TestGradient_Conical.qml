import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/ColorPicker/"
import "../../Controls/AnglePicker"


/**
测试渐变
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    // 锥形渐变
    Row{
        spacing: 10
        width: 400
        anchors.horizontalCenter: parent.horizontalCenter

        ConicalGradient {
            id: grdt
            width: 100; height: 100
            angle: sldAngle.value
            gradient: pkrGradient.gradient
            horizontalOffset: sldOffsetH.value
            verticalOffset: sldOffsetV.value
        }
        ConicalGradient {
            source: Image { source: '../Images/babi.png' }
            width: 100; height: 100
            angle: sldAngle.value
            gradient: pkrGradient.gradient
            horizontalOffset: sldOffsetH.value
            verticalOffset: sldOffsetV.value
        }
        ConicalGradient {
            source: Image { source: '../Images/babi2.png' }
            width: 100; height: 100
            angle: sldAngle.value
            gradient: pkrGradient.gradient
            horizontalOffset: sldOffsetH.value
            verticalOffset: sldOffsetV.value
        }
        ConicalGradient {
            source: Image { source: '../Images/babi3.png' }
            width: 100; height: 100
            angle: sldAngle.value
            gradient: pkrGradient.gradient
            horizontalOffset: sldOffsetH.value
            verticalOffset: sldOffsetV.value
        }
        ConicalGradient {
            source: Image { source: '../Images/babi4.png' }
            width: 100; height: 100
            angle: sldAngle.value
            gradient: pkrGradient.gradient
            horizontalOffset: sldOffsetH.value
            verticalOffset: sldOffsetV.value
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

        Text{text:'angle'}
        AnglePicker {id: sldAngle; value: 45; width:40; height:40}
        Text{text: Math.round(sldAngle.value)}

        Text{text:'gradient'}
        ColorGradientPicker {id: pkrGradient; gradient:Gradient {
                GradientStop { position: 0.000; color: Qt.rgba(1, 0, 0, 1) }
                GradientStop { position: 0.167; color: Qt.rgba(1, 1, 0, 1) }
                GradientStop { position: 0.333; color: Qt.rgba(0, 1, 0, 1) }
                GradientStop { position: 0.500; color: Qt.rgba(0, 1, 1, 1) }
                GradientStop { position: 0.667; color: Qt.rgba(0, 0, 1, 1) }
                GradientStop { position: 0.833; color: Qt.rgba(1, 0, 1, 1) }
                GradientStop { position: 1.000; color: Qt.rgba(1, 0, 0, 1) }
              }
        }
        Item{width:1; height:1}

        Text{text:'offset-h'}
        Slider {id: sldOffsetH; minimumValue: -10; maximumValue: 10; stepSize: 1.0; value: -3}
        Text{text: sldOffsetH.value}

        Text{text:'offset-v'}
        Slider {id: sldOffsetV; minimumValue: -10; maximumValue: 10; stepSize: 1.0; value: -3}
        Text{text: sldOffsetV.value}

    }
}


