import QtQuick 2.0


/**
测试WorkerScript，该对象可以在线程中运行代码
*/
Rectangle {
    width: 300; height: 300
    Text {
        id: myText
        text: 'Click anywhere'
    }

    WorkerScript {
        id: myWorker
        source: "workscript.js"
        onMessage: myText.text = messageObject.reply  // 接收线程反馈回来的数据
    }

    MouseArea {
        anchors.fill: parent
        onClicked: myWorker.sendMessage({ 'x': mouse.x, 'y': mouse.y }) // 启动线程，并发送消息
    }
}
