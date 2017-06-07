import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtSensors 5.1

/**
气泡水平仪
*/
Item {
    width: 700; height:700

    // 位置加速计
    Accelerometer {
        id: accelerometer
        active: true
        dataRate: 20
    }

    // 背景
    Rectangle {
        anchors.centerIn: parent
        width: 600
        height: 600
        radius: width / 2
        border.color: "#80c342"
        border.width: 10
        color: "#006224"
    }

    // 气泡
    Rectangle {
        id: ball
        width: 100
        height: 100
        //color: "#006224"
        color: "white"
        radius: width / 2
        property int centerX: parent.width / 2 - width / 2
        property int centerY: parent.height / 2 - height / 2
        Behavior on x { NumberAnimation { duration: 100 } }
        Behavior on y { NumberAnimation { duration: 100 } }
    }

    // 显示xy坐标
    ColumnLayout {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        Text {id: xValueText; text: "x: 0"}
        Text {id: yValueText; text: "y: 0"}
    }

    // 定时显示坐标；移动气泡位置
    Timer {
        interval: 16
        running: true
        repeat: true
        onTriggered: {
            ball.x = ball.centerX - accelerometer.reading.x * 30
            ball.y = ball.centerY + accelerometer.reading.y * 30
            xValueText.text = "x: " + accelerometer.reading.x.toFixed(2)
            yValueText.text = "y: " + accelerometer.reading.y.toFixed(2)
        }
    }
}
