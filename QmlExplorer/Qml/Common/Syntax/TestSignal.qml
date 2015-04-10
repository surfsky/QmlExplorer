import QtQuick 2.2
import QtQuick.Controls 1.1


// 发送自定义消息（请在TestConnections中测试)
Row {
    width: 100;
    height: 30;

    signal message1(string msg)
    signal message2(string msg)

    Rectangle{
        height: parent.height;
        width: parent.width/2
        color: 'lightgreen'
        border.color: 'white'
        border.width: 0
        MouseArea{
            anchors.fill: parent;
            onClicked: message1("L");
            onPressed: parent.border.width=2;
            onExited: parent.border.width=0;
        }
    }
    Rectangle{
        height: parent.height;
        width: parent.width/2
        color: 'lightblue'
        border.color: 'white'
        border.width: 0
        MouseArea{
            anchors.fill: parent;
            onClicked: message2("R");
            onPressed: parent.border.width=2;
            onExited: parent.border.width=0;
        }
    }
}
