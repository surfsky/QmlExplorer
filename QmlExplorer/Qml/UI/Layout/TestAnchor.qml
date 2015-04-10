import QtQuick 2.2

Item{
    width : 640
    height: 480

    // 方块之间相互对其
    Rectangle {
        id: rect1;
        x: 0;
        width: 40
        height: 40
        color:'red'
    }
    Rectangle {
        id: rect2;
        height: 40
        anchors.top: rect1.bottom
        anchors.left: rect1.right;
        anchors.right: rect3.left;
        color: 'green'
    }
    Rectangle {
        id: rect3;
        x: 150;
        width: 40
        height: 40
        color: 'blue'
    }

    //-------------------------------------
    // 上下左右
    //-------------------------------------
    // 下
    Rectangle {
        width: 40
        height: 40
        color: 'blue'

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        gradient: Gradient{
            GradientStop { position: 0.0; color: 'lightsteelblue'}
            GradientStop { position: 1.0; color: 'blue'}
        }
    }

    // 中
    Rectangle {
        id: rect4;
        width: 40
        height: 40
        color: 'green'
        anchors.centerIn: parent
    }

    // 上
    Rectangle {
        width: 40
        height: 40
        color: 'green'
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // 下
    Rectangle {
        width: 40
        height: 40
        color: 'green'
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // 左
    Rectangle {
        width: 40
        height: 40
        color: 'green'
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }

    // 右
    Rectangle {
        width: 40
        height: 40
        color: 'green'
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }


}

