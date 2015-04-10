import QtQuick 2.0
import QtMultimedia 5.0
import QtQuick.Controls 1.2

/**
背景音乐和点击音乐测试
Audio 可以播放wav文件，mp3不支持
*/
Rectangle{
    Audio {
        id: bgMusic
        source: "../../sound/bird.wav"
        autoPlay: true
        loops: -1
    }


    Text {
        text: "Click Me!";
        font.pointSize: 24;
        width: 150; height: 50;

        Audio {
            id: playMusic
            source: "../../sound/thunder.wav"
        }
        MouseArea {
            id: playArea
            anchors.fill: parent
            onPressed:  { playMusic.play() }
        }
    }

}

