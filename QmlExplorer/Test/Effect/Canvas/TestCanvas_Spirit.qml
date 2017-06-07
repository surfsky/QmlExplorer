import QtQuick 2.3

Canvas {
    id: canvas
    width: 600
    height: 600
    antialiasing: true

    onPaint: {
        var ctx = canvas.getContext("2d")
        player.draw(ctx)
    }

    // player精灵
    Item {
        id: player
        width: 50
        height: 50

        // 属性
        property color lineColor: Qt.rgba(0.35, 0.65, 0.17, 0.7)
        property real lastX: x
        property real lastY: y

        // 位置变更触发动画以及重绘操作
        onXChanged: canvas.requestPaint()
        onYChanged: canvas.requestPaint()
        Behavior on x { NumberAnimation { duration: 500 } }
        Behavior on y { NumberAnimation { duration: 500 } }

        // 绘制行走路径
        function draw(ctx) {
            ctx.beginPath()
            ctx.strokeStyle = lineColor
            ctx.lineWidth = 20
            ctx.lineCap = "round";
            //ctx.lineJoin="round";      // 线段连接处的样式
            var radius = width / 2
            ctx.moveTo(lastX + radius, lastY + radius)
            ctx.lineTo(x + radius, y + radius)
            ctx.stroke()
            lastX = x
            lastY = y
        }

        // 一个圆球充当精灵外观
        Rectangle {
            anchors.fill: parent
            color: "#006224"
            antialiasing: true
            radius: width / 2
        }
    }

    // 鼠标点击控制圆点位置
    MouseArea {
        anchors.fill: parent
        onClicked: {
            player.x = mouseX - player.width / 2
            player.y = mouseY - player.height / 2
        }
    }
}
