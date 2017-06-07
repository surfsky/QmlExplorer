import QtQuick 2.0


/**
switch 示例
   背景色
   前景色
   文本
   值
   动画
**/
Rectangle {
    id: root
    width: 200
    height: 100
    radius: height/2
    color: '#e0e0e0'

    property bool value: true;
    onValueChanged: {
        if (value) prog.x = 0;
        else       prog.x = root.width-prog.width;
    }

    Rectangle{
        id: prog
        height: parent.height
        width: parent.height
        radius: height/2
        color: root.value ? '#18a754' : '#e0483e'
        Behavior on color{
            ColorAnimation { duration: 200 }
        }
        Behavior on x{
            PropertyAnimation{duration:200; easing.type: Easing.OutExpo}
        }
        Text{
            anchors.centerIn: parent
            font.pixelSize: parent.height*1/2
            text: root.value ? 'ON' : 'OFF'
            color: 'white'
        }
    }

    // 定义鼠标可拖动区域
    MouseArea {
        anchors.fill: parent
        drag.target: prog;
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: parent.width-parent.height
        drag.filterChildren: true
        clip: true
        onPressed: console.log('press');
        onReleased: root.value = prog.x+prog.width/2 < root.width/2;
        onExited: {
            console.log(mouse.x);
            root.value = prog.x+prog.width/2 < root.width/2;
        }
        onClicked: {
            root.value = mouse.x < root.width/2;
        }
    }
}
