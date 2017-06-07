/**
测试拖拽
*/
import QtQuick 2.0
Rectangle {
    width: 300; height: 300
    color: "lightsteelblue"

    //-----------------------------
    // 方式1
    //-----------------------------
    // 定义鼠标可拖动区域
    MouseArea {
        anchors.fill: parent
        drag.target: rect;
        drag.axis: Drag.XAndYAxis
        drag.minimumX: 30
        drag.maximumX: 150
        drag.filterChildren: true
        clip: true
    }

    // 待拖拽对象
    Rectangle {
        id: rect
        color: "yellow"
        x: 50; y : 50
        width: 100; height: 100
    }


    //-----------------------------
    // 方式2
    //-----------------------------
    // 待拖拽对象
    Rectangle {
        x: 10; y: 10
        width: 40; height: 40
        color: "red"

        //
        Drag.active: dragArea.drag.active
        Drag.hotSpot.x: 5
        Drag.hotSpot.y: 5
        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent    //
        }
    }
}
