import QtQuick 2.3


/***
测试ListView增加元素的动画
*/
ListView {
    width: 240; height: 320
    model: ListModel {}

    delegate: Rectangle {
        width: 100; height: 30
        border.width: 1
        color: "lightsteelblue"
        Text {
            anchors.centerIn: parent
            text: name
        }
    }
    header: Text{
        text: 'press space to add item'
    }

    // 新增-过渡动画
    add: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400; alwaysRunToEnd: true;}
        NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400; alwaysRunToEnd: true;}
    }
    displaced: Transition {
        NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
        // ensure opacity and scale values return to 1.0
        NumberAnimation { property: "opacity"; to: 1.0 }
        NumberAnimation { property: "scale"; to: 1.0 }
    }

    focus: true
    Keys.onSpacePressed: model.insert(0, { "name": "Item " + model.count })
}
