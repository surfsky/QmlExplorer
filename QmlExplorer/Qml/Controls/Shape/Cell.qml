import QtQuick 2.0

/**
一个小色块，居中放置一个文本
*/
Rectangle {
    width: 40
    height: 40
    color: 'lightblue'
    property alias text : text1.text
    property alias fontColor : text1.color
    smooth: true

    Text{
        id: text1
        text : 'text'
        color: 'white'
        font.pixelSize: 12
        antialiasing: true
        anchors.centerIn: parent
    }
}
