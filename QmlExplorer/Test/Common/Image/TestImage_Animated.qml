import QtQuick 2.0

/**
测试动画图片（如gif）
与images不同, AnimatedImages不内置支持缓存
*/
Rectangle {
    width: gif.width;
    height: gif.height + 8
    color: 'black'

    // 动画图片
    AnimatedImage {
        id: gif;
        source: "apple.gif"
        MouseArea{
            anchors.fill: parent
            onClicked: gif.playing = !gif.playing
        }
    }

    // 显示当前帧
    property alias cnt : gif.frameCount
    Text{
        text: gif.currentFrame + "/" + cnt
        anchors.centerIn: parent
    }
    Rectangle {
        width: 4
        height: 8
        x: (gif.width - width) * gif.currentFrame / cnt
        y: gif.height
        color: "red"
    }
}
