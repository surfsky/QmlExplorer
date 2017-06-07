import QtQuick 2.0

/**
测试鼠标拖拽放下操作
*/
Item {
    width: 200; height: 200

    // 可drop区域
    DropArea {
        x: 75; y: 75
        width: 50; height: 50
        Rectangle {
            anchors.fill: parent
            color: parent.containsDrag ? "green" : '#d0d0d0'
        }
    }


    // 待拖拽对象
    Rectangle {
        x: 10; y: 10
        width: 20; height: 20
        color: "red"

        //
        Drag.active: dragArea.drag.active
        Drag.hotSpot.x: 5
        Drag.hotSpot.y: 5

        //
        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent    //
        }
    }
}
