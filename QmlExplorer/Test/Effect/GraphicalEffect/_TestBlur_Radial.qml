import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"


/**
测试轴向模糊（无任何效果？）
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10


    Image {
        id: img;
        source: "../images/bug.png";
        visible: false
    }
    RadialBlur {
        source: img
        width: source.width
        height: source.height
        anchors.horizontalCenter: parent.horizontalCenter
        samples: sldSamples.value
        angle: sldAngle.value-90    // 径向模糊角度范围-180~180
        horizontalOffset: sldOffsetH.value
        verticalOffset: sldOffsetV.value
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

        Text{text:'samples'}
        Slider {id: sldSamples; minimumValue: 1.0; maximumValue: 32.0; stepSize: 1.0; value: 24}
        Text{text: sldSamples.value}

        Text{text:'angle'}
        AnglePicker {id: sldAngle; value: 90; width:40; height:40}
        Text{text: Math.round(sldAngle.value)}

        Text{text:'offset-h'}
        Slider {id: sldOffsetH; minimumValue: -10; maximumValue: 10; stepSize: 1.0; value: -3}
        Text{text: sldOffsetH.value}

        Text{text:'offset-v'}
        Slider {id: sldOffsetV; minimumValue: -10; maximumValue: 10; stepSize: 1.0; value: -3}
        Text{text: sldOffsetV.value}

        Text{text:'transparentBorder'}
        Switch{id: swhTransparentBorder; checked : false; }
        Item{width:1; height:1}
    }
}
