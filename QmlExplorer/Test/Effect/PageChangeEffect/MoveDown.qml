import QtQuick 2.3

/**
垂直向下退场
*/
Rectangle {
    width: 360; height: 630
    Image {
        id: front
        source: "image/pic1.png"
        Image {
            id: back
            source: "image/pic2.png"
            NumberAnimation on y{
                id: animation2
                running: false
                to: 630;
                duration: 1000;
                easing.type: Easing.InOutElastic;//Easing.OutExpo
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked:animation2.running=true
        }
    }
}
