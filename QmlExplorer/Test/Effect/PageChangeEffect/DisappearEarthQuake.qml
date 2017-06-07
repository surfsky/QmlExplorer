import QtQuick 2.3

/**
顶图剧烈震动后消失
*/
Rectangle {
    width: front.width;
    height: front.height

    Image {
        id: front
        source: "Image/pic2.png"
        Image{
            id: back
            source: "Image/pic1.png"
            SequentialAnimation on x {
                running:false
                id: animation1
                loops: 50
                PropertyAnimation {easing.type: Easing.InOutElastic;to: 8  ;duration:10}
                PropertyAnimation {easing.type: Easing.OutInElastic; to: 0 ;duration:10}
            }
            SequentialAnimation on y {
                id: animation2
                running:false
                loops: 50
                PropertyAnimation { easing.type: Easing.InOutBounce;to: 8  ;duration:10}
                PropertyAnimation { easing.type: Easing.OutInBounce;to: 0 ;duration:10}
            }
        }
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            animation1.running = true;
            animation2.running = true;
            back.destroy(1000);
        }
    }
}
