import QtQuick 2.3

/**
翻转切换效果
*/
Rectangle{
    width: 360; height: 680
    Flipable {
        id: flipable
        width: 360; height: 640
        SystemPalette { id: activePalette }
        property int angle: 0
        property bool flipped: false

        front: Image { source: "Image/pic1.png" }
        back: Image { source: "Image/pic2.png" }

        transform: Rotation {
            origin.x: flipable.width/2; origin.y: flipable.height/2
            axis.x: 0; axis.y: 1; axis.z: 0     // rotate around y-axis
            angle: flipable.angle
        }

        states: State {
            name: "back"
            PropertyChanges { target: flipable; angle:180 }
            when: flipable.flipped
        }
        transitions: Transition {
            NumberAnimation { easing.type: Easing.OutBounce;properties: "angle"; duration: 1000 }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: flipable.flipped = !flipable.flipped
        }
    }
}
