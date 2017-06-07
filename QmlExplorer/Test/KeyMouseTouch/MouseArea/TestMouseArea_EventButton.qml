/**
测试鼠标左右按键
*/
import QtQuick 2.0
Rectangle {
    width: 100; height: 100
    color: "green"

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button == Qt.RightButton)
                parent.color = 'blue';
            else
                parent.color = 'red';
        }
    }
}
