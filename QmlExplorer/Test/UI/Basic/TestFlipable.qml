import QtQuick 2.2
import QtQuick.Controls 1.1
import "../../controls/"

/**
测试Flipable组件：有两面，可翻转
但翻转变形以及过渡动画都要自己写，太麻烦了，可考虑二次封装一下
已封装成FlipableEx.qml 组件，只需填写front, back属性即可
*/
Item{
    width: 640
    height: 480

    Flipable {
        id: flipable
        width: 40
        height: 40
        front: Cell { text: "front"; color:"red" }
        back:  Cell { text: "back" ; color:"green"}

        // property
        property int angle: 0
        property bool flipped: false

        // 点击->属性变更->状态变更->角度变更
        MouseArea {
            anchors.fill: parent
            onClicked: flipable.flipped = !flipable.flipped
        }
        states: State {
            name: "back"
            when: flipable.flipped
            PropertyChanges { target: flipable; angle: 180 }
        }
        // 角度变更->变形
        transform: Rotation {
            origin.x: flipable.width/2;
            origin.y: flipable.height/2
            axis.x: 0; axis.y: 1; axis.z: 0
            angle: flipable.angle
        }

        // 变形->变形过渡动画
        transitions: Transition {
            NumberAnimation { properties: "angle"; duration: 500 }
        }
    }
}

