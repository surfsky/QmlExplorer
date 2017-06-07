import QtQuick 2.0
import QtAV 1.3


/**
测试QtQV库
*/
Item {
    VideoOutput {
        anchors.fill: parent
        source: player
    }
    AVPlayer { //or MediaPlayer
        id: player
        source: "test.mp4"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: player.play()
    }
}
