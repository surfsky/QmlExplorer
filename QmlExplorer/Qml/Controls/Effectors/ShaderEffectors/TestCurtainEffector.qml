import QtQuick 2.0
Rectangle {
    id: root
    width: 480; height: 240
    color: '#1e1e1e'

    Image {
        anchors.centerIn: parent
        source: "../images/bug.png"
    }

    CurtainEffector {
        id: curtain
        anchors.fill: parent
        coverSource: "../images/fabric.jpg"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: curtain.open = !curtain.open
    }
}
