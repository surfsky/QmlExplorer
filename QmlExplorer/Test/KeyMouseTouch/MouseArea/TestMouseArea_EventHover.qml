/**
鼠标悬浮测试
*/
import QtQuick 2.3
Rectangle {
    width: 600; height: 600;

    // 三态：正常蓝色、悬浮绿色、点击红色
    Rectangle{
        x:100; y:100; width:300; height: 300;
        color: mouse.pressed
               ? 'red'
               : (mouse.containsMouse ? 'green' : 'blue')
        MouseArea{
            id: mouse
            anchors.fill: parent;
            hoverEnabled: true
        }

    }

}
