import QtQuick 2.3

/**
水平右移
*/
Rectangle {
    width: 360; height: 630
    Image {
        id: front
        source: "image/pic1.png"
        Image {
            id: back
            source: "image/pic2.png"

            NumberAnimation on x{
                id: animation2
                running:false
                to: 360;
                duration: 1000;
                easing.type: Easing.OutExpo  //InOutElastic
            }
        }
    }
    MouseArea {
          anchors.fill: parent
          onClicked:animation2.running=true
    }
}
