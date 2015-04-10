import QtQuick 2.0
import "."

/**
测试自定义的动画
*/
Rectangle {
    width: 400
    height: 400

    Rectangle{
        width: 50
        height: 50
        color: 'green'
        MouseArea{
            anchors.fill: parent
            onClicked: Animations.playAnimation(parent, 'X');
        }
    }
}

