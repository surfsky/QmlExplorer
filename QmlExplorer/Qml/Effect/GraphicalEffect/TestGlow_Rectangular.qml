import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"



/**
测试矩形发光效果。该组件有较好的性能。
这玩意就是简化版的drop shadow
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10
    Rectangle {
        id: background
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300; height: 200
        color: "black"


        RectangularGlow {
            id: effect
            anchors.fill: rect
            spread: sldSpread.value
            color: pkrColor.color
            cornerRadius: rect.radius + glowRadius
            glowRadius: sldRadius.value
        }

        Rectangle {
            id: rect
            color: "black"
            width: Math.round(parent.width / 1.5)
            height: Math.round(parent.height -20)
            anchors.horizontalCenter: parent.horizontalCenter
            y: 10
            radius: 25
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


        Text{text:'spread'}
        Slider {id: sldSpread; minimumValue: 0.1; maximumValue: 1.0; stepSize: 0.1; value: 0.2}
        Text{text: sldSpread.value}

        Text{text:'radius'}
        Slider {id: sldRadius; minimumValue: 1.0; maximumValue: 30.0; stepSize: 1.0; value: 20}
        Text{text: sldRadius.value}

        Text{text:'color'}
        ColorPicker {id: pkrColor; color: 'white'; }
        Item{width:1; height:1}
    }
}
