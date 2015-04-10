import QtQuick 2.2
import QtQuick.Controls 1.1


/**
封装 Flipable组件，有两面，可翻转，带动画
示例
    FlipableEx{
        width: 100
        height: 40
        anchors.centerIn: parent
        front: Cell { text: "front"; color:"red"; width: 100;}
        back:  Cell { text: "back" ; color:"green"; width:100}
    }
*/
Flipable {
    id: flipable
    anchors.centerIn: parent;
    width: front.width
    height: front.height
    //front: Rectangle {color:"red";   width:100; height: 100;}
    //back:  Rectangle {color:"green"; width:100; height: 100;}

    // 属性
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
