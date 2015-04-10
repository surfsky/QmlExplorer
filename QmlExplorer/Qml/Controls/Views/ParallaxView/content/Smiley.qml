import QtQuick 2.0

/**
动画笑脸
*/
Item {
    id: window
    width: 320; height: 480

    // 阴影
    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        y: smiley.minHeight + 58
        source: "pics/shadow.png"
        scale: smiley.y * 0.5 / (smiley.minHeight - smiley.maxHeight)
    }

    // 动画笑脸
    Image {
        id: smiley
        property int maxHeight: window.height / 3
        property int minHeight: 2 * window.height / 3

        anchors.horizontalCenter: parent.horizontalCenter
        y: minHeight
        source: "pics/face-smile.png"

        // 跳跃动画
        SequentialAnimation on y {
            loops: Animation.Infinite
            NumberAnimation {
                from: smiley.minHeight; to: smiley.maxHeight
                easing.type: Easing.OutExpo; duration: 300
            }
            NumberAnimation {
                from: smiley.maxHeight; to: smiley.minHeight
                easing.type: Easing.OutBounce; duration: 1000
            }
            PauseAnimation { duration: 500 }
        }
    }
}

