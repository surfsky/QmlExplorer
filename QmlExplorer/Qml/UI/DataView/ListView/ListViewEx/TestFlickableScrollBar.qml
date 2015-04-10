import QtQuick 2.0

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
            source: "images/bigimg.jpg"
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
