import QtQuick 2.0
import "../../Cool/Effector"


/**
鼠标悬停点击会动画发光的按钮（呼吸灯效果、dropshadow实现）
*/
Item{
    width: 160
    height: 60
    Rectangle{
        id:shineButton
        width: parent.width
        height: parent.height
        radius: 10
        color: 'lightblue'
        Text{anchors.centerIn: parent; color:'white'; text:'Press me'; font.pixelSize: 20}
        MouseArea{
            anchors.fill: parent
            onPressed: effector.start();
            onReleased: effector.stop();

            hoverEnabled: true
            onEntered: effector.start();
            onExited:  effector.stop();
        }
    }
    ShineEffector{
        id: effector
        shineSource: shineButton
        shineRadius: 40
        shineColor: 'yellow'
    }
}

