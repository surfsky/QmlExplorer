import QtQuick 2.0


/**
测试FlickableScrollBar
Lisence: MIT 请保留此声明
Author: surfsky.cnblogs.com 2014-12
*/
Rectangle {
    width: 640
    height: 480

    Flickable {
        id: view
        anchors.fill: parent
        contentWidth: picture.width
        contentHeight: picture.height
        Image {
            id: picture
            source: "pics/niagara_falls.jpg"
            asynchronous: true
        }
    }

    FlickableScrollBar {
        target: view
        orientation: Qt.Vertical
    }
    FlickableScrollBar {
        target: view
        orientation: Qt.Horizontal
    }
}
