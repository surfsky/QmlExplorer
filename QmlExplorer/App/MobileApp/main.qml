import QtQuick 2.3
import QtQml.Models 2.1
import QtQuick.XmlListModel 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2

/**
app 框架示例
- 顶部系统工具栏
- 中部grid
- 底部tabbar

感谢Q友提供示例代码：vim@vimer.org(13658616)
发布前请用其他图片替代
注：窗体拖动闪动厉害，这应该是MouseArea的事件频率不够的缘故，期待有更好的解决方案
*/
Window {
    id: window
    width: 360
    height: 600
    visible: true
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height
    flags: Qt.Window | Qt.FramelessWindowHint

    //---------------------------------------------
    // 可拖拽移动窗口
    //---------------------------------------------
    MouseArea {
        id: windowMove
        anchors.fill: parent;
        property int _x : 0
        property int _y : 0
        onPressed: { _x = mouse.x; _y = mouse.y }
        onPositionChanged: {
            window.setX(window.x + (mouse.x - _x));
            window.setY(window.y + (mouse.y - _y));
        }
    }


    //---------------------------------------------
    // 背景
    //---------------------------------------------
    Image {
        id: windowBackground
        source: "image/bg0.png"
    }

    //---------------------------------------------
    // 系统工具栏
    //---------------------------------------------
    Row {
        id: systemButtons
        anchors.top: parent.top; anchors.topMargin: 6
        anchors.right: parent.right; anchors.rightMargin: 11
        spacing: 16
        Repeater {
            model: 3
            Button {
                width: 15; height: 15
                iconSource: hovered ? "image/sys" + index + "b.png" : "image/sys" + index + "a.png"
                style: ButtonStyle { background: Image { source: control.iconSource } }
                onClicked: systemButtons.onSysClicked(index)
            }
        }
        function onSysClicked(index)
        {
            switch(index)
            {
                case 0: break;
                case 1: window.showMinimized(); break;
                case 2: Qt.quit(); break;
            }
        }
    }


    //---------------------------------------------
    //
    //---------------------------------------------
    Item {
        id: tabPage1
        visible: tabButtons.state == "tab1"
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.horizontalCenter: parent.horizontalCenter
        width: 79 * 4
        height: 94 * 4
        XmlListModel {
            id: gameXml
            source: "image/game/game.xml"
            query: "/list/item"
            XmlRole { name: "name"; query: "name/string()"; isKey: true }
            onCountChanged: { gameListModel.clear(); for(var i = 0; i < count / 16; ++i) gameListModel.append({"page_index":i}) }
        }
        ListView {
            id: gameListView
            anchors { fill: parent; bottomMargin: 30 }
            preferredHighlightBegin: 0; preferredHighlightEnd: 0
            highlightRangeMode: ListView.StrictlyEnforceRange
            orientation: ListView.Horizontal
            snapMode: ListView.SnapOneItem; flickDeceleration: 2000
            cacheBuffer: 200
            model: ListModel{ id: gameListModel }
            delegate: Grid {
                width: 360; columns: 4
                Repeater {
                    model: gameXml.count - 16 * page_index > 16 ? 16 : gameXml.count - 16 * page_index
                    Item {
                        width: 79; height: 94
                        Button {
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 55; height: 54
                            iconSource: hovered ? "image/gamebgb.png" : "image/gamebga.png"
                            style: ButtonStyle { background: Item { Image { source: control.iconSource } } }
                            onClicked: {console.log("game" + (16 * page_index + index))}
                            Image { anchors.centerIn: parent; source: "image/game/icon" + (16 * page_index + index) + ".png" }
                        }
                        Image {
                            anchors.top: parent.top
                            anchors.topMargin: 63
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "image/game/name" + (16 * page_index + index) + ".png"
                        }
                    }
                }
            }
        }
        Row {
            anchors.top: parent.top
            anchors.topMargin: 398
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 7
            Repeater {
                model: gameXml.count
                Button {
                    visible: index == 0 ? gameXml.count > 16 : gameXml.count - 16 * index > 0
                    width: 8; height: 8
                    iconSource: gameListView.currentIndex == index ? "image/dotb.png" : "image/dota.png"
                    style: ButtonStyle { background: Image { source: control.iconSource } }
                    onClicked: gameListView.currentIndex = index
                }
            }
        }
    }
    Grid {
        id: tabPage0
        visible: tabButtons.state == "tab0"
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.horizontalCenter: parent.horizontalCenter
        height: 94 * 4; width: 79 * 4; columns: 4;
        Repeater {
            model: 2
            Item {
                width: 79; height: 94
                Button {
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 55; height: 54
                    iconSource: hovered ? "image/gamebgb.png" : "image/gamebga.png"
                    style: ButtonStyle { background: Item { Image { source: control.iconSource } } }
                    onClicked: {console.log("game" + index)}
                    Image { anchors.centerIn: parent; source: "image/game/icon" + index + ".png" }
                }
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 63
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "image/game/name" + index + ".png"
                }
            }
        }
    }

    //---------------------------------------------
    // 底部Tab工具栏
    //---------------------------------------------
    Row{
        id: tabButtons
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.horizontalCenter: parent.horizontalCenter
        height: 60
        Repeater {
            model: 3
            Button {
                width: 108
                height: 60
                iconSource: parent.state == "tab" + index ? "image/tab" + index + "b.png" : "image/tab" + index + "a.png"
                style: ButtonStyle { background: Image { source: control.iconSource } }
                onClicked: parent.state = "tab" + index
            }
        }
        state: "tab1"
        states: [
            State { name: "tab0" },
            State { name: "tab1" },
            State { name: "tab2" }
        ]
    }
}
