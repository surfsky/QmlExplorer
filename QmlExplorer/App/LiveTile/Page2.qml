import QtQuick 2.0
import QtQuick.Controls 1.2

/**
考虑用信号机制通知main窗口关闭自身
*/
Page {
    width: 360
    height: 360
    color: "lightblue"
    Text {
        y: 10
        text: "Page2"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button{
        text: 'close'
        anchors.centerIn: parent
        onClicked: exit(parent);
    }
}
