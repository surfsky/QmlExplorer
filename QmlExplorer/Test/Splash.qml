import QtQuick 2.0
import QtQuick.Window 2.1


/**
欢迎屏（模态、透明、居中、图片、定时消失）
属性
    imageUrl
    duration
signal
    timeout
*/
Window {
    id: splash

    // 属性
    property int duration: 2000
    property alias imageUrl : splashImage.source
    signal timeout

    // 模态、透明、居中
    color: "transparent"
    title: "Splash Window"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    x: (Screen.width - splashImage.width) / 2
    y: (Screen.height - splashImage.height) / 2
    width: splashImage.width
    height: splashImage.height

    // 图片
    Image {
        id: splashImage
        source: "../images/qt512.png"
        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }

    // 定时消失（可扩展定义多种消失方式）
    Timer {
        interval: duration;
        running: true;
        repeat: false
        onTriggered: {
            animation.start();
        }
    }
    PropertyAnimation{
        id: animation
        target: splash
        properties: 'opacity'
        from: 1.0
        to: 0.0
        duration: 1000
        onStopped: {
            splash.visible = false;
            splash.timeout();
        }
    }

    // 初始化
    Component.onCompleted: {
        visible = true;
        opacity = 1.0;
    }
}
