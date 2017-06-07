import QtQuick 2.0


Rectangle {
    width: 360
    height: 360
    color: "lightgreen"
    Text {
        text: qsTr("Page1")
        anchors.centerIn: parent
    }
    Component.onCompleted: console.log('create  page1');
    Component.onDestruction: console.log('destory page1');
}
