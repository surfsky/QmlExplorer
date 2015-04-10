import QtQuick 2.0

Rectangle {
    width: 360
    height: 360
    color: 'pink'
    Text {
        text: qsTr("Page2")
        anchors.centerIn: parent
    }
    Component.onCompleted: console.log('create  page2');
    Component.onDestruction: console.log('destory page2');
}
