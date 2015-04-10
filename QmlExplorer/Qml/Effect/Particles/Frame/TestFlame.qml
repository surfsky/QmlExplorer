import QtQuick 2.0
import QtQuick.Controls 1.2

/**
测试多重触摸区域以及自定义粒子
*/
Rectangle {
    width: 640
    height: 480
    color: 'black'

    ComboBox{
        id: cmb
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        z: 99
        width: 200
        model: ["heart.png", "circle.png", "circle-big.png"]
        currentIndex: 0
    }

    // 定义了5个可触摸点
    MultiPointTouchArea {
        anchors.fill: parent
        minimumTouchPoints: 1
        maximumTouchPoints: 5
        touchPoints: [
            TouchPoint { id: touch1 },
            TouchPoint { id: touch2 },
            TouchPoint { id: touch3 },
            TouchPoint { id: touch4 },
            TouchPoint { id: touch5 }
        ]
    }

    // 5个触摸点点击后会出现火焰粒子
    Flame{ color: 'red';    point: touch1; enabled:touch1.pressed; image: 'images/' + cmb.currentText}
    Flame{ color: 'green';  point: touch2; enabled:touch2.pressed; image: 'images/' + cmb.currentText}
    Flame{ color: 'blue';   point: touch3; enabled:touch3.pressed; image: 'images/' + cmb.currentText}
    Flame{ color: 'yellow'; point: touch4; enabled:touch4.pressed; image: 'images/' + cmb.currentText}
    Flame{ color: 'violet'; point: touch5; enabled:touch5.pressed; image: 'images/' + cmb.currentText}
}
