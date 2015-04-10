import QtQuick 2.0

/**
group button
*/
Rectangle {
    id: button

    property bool active: buttonGroup.activeButton == button
    property bool fullDiscovery: false
    property alias text: label.text

    signal clicked()
    height: label.height*1.1

    color: active ? "#1c56f3" : "white"

    radius: 5
    border.width: 2

    Text {
        id: label
        text: "Full Discovery"
        font.bold: true
        font.pointSize: 17
        width: parent.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            button.clicked()
            //Reset the model
            btModel.running = false
            btModel.running = true
            buttonGroup.activeButton = button
        }
    }
}
