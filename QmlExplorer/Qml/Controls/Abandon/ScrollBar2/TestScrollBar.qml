import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    width: 300
    height: 300

    ListView {
        id: myList
        anchors.fill: parent
        model: 1
        delegate: Image {source: "./images/1.png"}
    }
    ScrollBar {
        target: myList
    }
}
