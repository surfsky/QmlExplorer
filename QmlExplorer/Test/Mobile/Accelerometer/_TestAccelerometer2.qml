/**
移动设备重力加速器测试
控制一个小球根据重力感应移动
*/
import QtQuick 2.0
import QtSensors 5.3
Item {
    anchors.fill: parent
    Accelerometer{
        id: accelerometer
        active: true
        dataRate: 20
    }
    Rectangle{
        id: ball
        x: 300
        y: 300
        width: 50
        height: 50
        color: '#024c1c'
        antialiasing: true
        radius: width/2
    }
    Timer{
        interval: 16
        running: true
        repeat: true
        onTriggered: {
            ball.x -= accelerometer.reading.x;
            ball.y += accelerometer.reading.y;
        }
    }

}
