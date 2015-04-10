import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"


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
        width: 200
        anchors.horizontalCenter: parent.horizontalCenter

        RadialGradient {
            width: 100; height: 100
            angle: sldAngle.value //// BUG: 无效
            horizontalOffset: sldOffsetV.value
            verticalOffset: sldOffsetH.value
            horizontalRadius: sldRadiusH.value
            verticalRadius: sldRadiusV.value
            gradient: pkrGradient.gradient
        }
        RadialGradient {
            width: 100; height: 100
            source: Image { source: '../Images/babi.png' }
            angle: sldAngle.value //// BUG: 无效
            horizontalOffset: sldOffsetV.value
            verticalOffset: sldOffsetH.value
            horizontalRadius: sldRadiusH.value
            verticalRadius: sldRadiusV.value
            gradient: pkrGradient.gradient
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
        ColorGradientPicker {id: pkrGradient;}
        Text{text: Math.round(pkrGradient.gradient.stops.length)}

        Text{text:'offset-h'}
        Slider {id: sldOffsetH; minimumValue: -100; maximumValue: 100; stepSize: 1.0; value: -3}
        Text{text: sldOffsetH.value}

        Text{text:'offset-v'}
        Slider {id: sldOffsetV; minimumValue: -100; maximumValue: 100; stepSize: 1.0; value: -3}
        Text{text: sldOffsetV.value}

        Text{text:'radiusH'}
        Slider {id: sldRadiusH; minimumValue: 1.0; maximumValue: 200.0; stepSize: 1.0; value: 40}
        Text{text: sldRadiusH.value}

        Text{text:'radiusV'}
        Slider {id: sldRadiusV; minimumValue: 1.0; maximumValue: 200.0; stepSize: 1.0; value: 100}
        Text{text: sldRadiusV.value}

    }
}


