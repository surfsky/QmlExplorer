import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"
import "../../Controls/Drawing/Gradient"



Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    Row{
        width: 220
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        // 线性渐变
        LinearGradient {
            width: 100; height: 100
            start: Qt.point(0, 0)
            end: Qt.point(80, 80) //// BUG：无效
            gradient: pkrGradient.gradient;
        }

        // 依赖source组件内部绘制
        LinearGradient {
            source: Image { source: '../Images/butterfly.PNG' }
            width: 100; height: 100
            start: Qt.point(0, 0)
            end: Qt.point(80, 80)
            gradient: pkrGradient.gradient;
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


        Text{text:'gradient'}
        ColorGradientPicker{id: pkrGradient}
        Item{width:1; height:1}
    }
}
