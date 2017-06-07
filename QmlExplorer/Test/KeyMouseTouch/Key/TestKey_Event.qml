import QtQuick 2.0


/**
测试键盘事件
Keys.onSpacePressed()
Keys.onPressed()
Keys.onReleased()
KeyNavigation
*/
Rectangle{
    width: 600
    height: 600

    Rectangle {
        id: rect
        x: 200;
        y: 200
        width: 100
        height: 100
        color: 'green'
        focus: true   // 这个必须加，否则不接收键盘事件
    }

    Keys.onSpacePressed: rect.color='blue'
    Keys.onLeftPressed:  rect.x -=5
    Keys.onRightPressed: rect.x += 5
    Keys.onUpPressed:    rect.y -=5
    Keys.onDownPressed:  rect.y +=5
    Keys.onPressed: {
        if (event.key == Qt.Key_Left) {
            console.log("move left");
            event.accepted = true;
        }
    }
}

