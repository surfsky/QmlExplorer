import QtQuick 2.0

/**
GridView测试：动画高亮选择项目
*/
Rectangle {
    width: 300; height: 400
    color: "white"

    ListModel {
        id: appModel
        ListElement { name: "Music"; icon: "../../../../images/qt58.png" }
        ListElement { name: "Movies"; icon: "../../../../images/qt58.png" }
        ListElement { name: "Camera"; icon: "../../../../images/qt58.png" }
        ListElement { name: "Calendar"; icon: "../../../../images/qt58.png" }
        ListElement { name: "Messaging"; icon: "../../../../images/qt58.png" }
        ListElement { name: "Todo List"; icon: "../../../../images/qt58.png" }
        ListElement { name: "Contacts"; icon: "../../../../images/qt58.png" }
    }

    GridView {
        anchors.fill: parent
        cellWidth: 100; cellHeight: 100
        focus: true
        model: appModel

        delegate: Item {
            width: 100; height: 100
            Image {
                id: myIcon
                y: 20; anchors.horizontalCenter: parent.horizontalCenter
                source: icon
            }
            Text {
                anchors { top: myIcon.bottom; horizontalCenter: parent.horizontalCenter }
                text: name
            }
            MouseArea {
                anchors.fill: parent
                onClicked: parent.GridView.view.currentIndex = index
            }
        }

        // 高亮：作为元素的背景存在，已经包含了动画逻辑
        // 如何控制动画逻辑？
        highlight: Rectangle { width: 80; height: 80; color: "lightsteelblue" }
    }
}
