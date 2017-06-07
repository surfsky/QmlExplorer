import QtQuick 2.0

Rectangle {
    width: 360
    height: 360
    color: 'lightblue'
    Text {
        text: qsTr("Page3")
        anchors.centerIn: parent
    }
    Component.onCompleted: console.log('create  page3');
    Component.onDestruction: console.log('destory page3');
}
