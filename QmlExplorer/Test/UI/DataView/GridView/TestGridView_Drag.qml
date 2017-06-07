import QtQuick 2.0
import QtQml.Models 2.1

/**
卡片式多选视图(改自view官方示例)
- 点击右上角选中后，可以拖动卡片重新排序
- 内部逻辑：选中模块拖动一触发，该元素就从model中移除，drop的时候再插入进去

其中的拖放逻辑，有空再好好研究一下
*/
Item {
    id: root
    width: 320
    height: 480

    property bool dragging: false



    //-----------------------------------
    // 选中拖动时卡片放置的路径
    //-----------------------------------
    PathView {
        id: selectionView
        height: 64
        width: 64
        model: visualModel.parts.selection
        path: Path {
            startX: 0
            startY: 0
            PathLine { x: 64; y: 64 }
        }
    }

    //-----------------------------------
    // grid
    //-----------------------------------
    GridView {
        id: itemsView
        anchors { fill: parent }
        cellWidth: 64
        cellHeight: 64
        model: visualModel.parts.visible
    }

    DelegateModel {
        id: visualModel
        model: 35
        delegate: packageDelegate
        groups: VisualDataGroup { id: selectedItems; name: "selected" }
        Component.onCompleted:  parts.selection.filterOnGroup = "selected"
    }


    //-----------------------------------
    // delegate
    //-----------------------------------
    Component {
        id: packageDelegate
        Package {
            id: packageRoot

            // ???
            MouseArea {
                id: visibleContainer
                Package.name: "visible"   //
                width: 64
                height: 64
                enabled: packageRoot.DelegateModel.inSelected
                drag.target: draggable
                Item {
                    id: draggable
                    width: 64
                    height: 64
                    Drag.active: visibleContainer.drag.active
                    anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                    states: State {
                        when: visibleContainer.drag.active
                        AnchorChanges { target:  draggable; anchors { horizontalCenter: undefined; verticalCenter: undefined} }
                        ParentChange { target: selectionView; parent: draggable; x: 0; y: 0 }
                        PropertyChanges { target: root; dragging: true }
                        ParentChange { target: draggable; parent: root }
                    }
                }
                DropArea {
                    anchors.fill: parent
                    onEntered: selectedItems.move(0, visualModel.items.get(packageRoot.DelegateModel.itemsIndex), selectedItems.count)
                }
            }

            // 选中后拖动时的容器
            Item {
                id: selectionContainer
                Package.name: "selection"
                width: 64
                height: 64
                visible: PathView.onPath
            }

            // 卡片
            Rectangle {
                id: content
                parent: visibleContainer
                width: 58
                height: 58
                radius: 8
                border.width: 2
                border.color: "#007423"
                gradient: Gradient {
                    GradientStop { id: gradientStart; position: 0.0; color: "#8AC953" }
                    GradientStop { id: gradientEnd; position: 1.0; color: "#8BC953" }
                }

                state: root.dragging && packageRoot.DelegateModel.inSelected ? "selected" : "visible"

                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    text: modelData
                    font.pixelSize: 18
                }

                // 卡片选择标志（右上角圆点）
                Rectangle {
                    anchors { right: parent.right; top: parent.top; margins: 3 }
                    width: 12; height: 12
                    color: packageRoot.DelegateModel.inSelected ? "red" : "white"
                    radius: 6
                    border.color: "white"
                    border.width: 2
                    MouseArea {
                        anchors.fill: parent
                        onClicked: packageRoot.DelegateModel.inSelected = !packageRoot.DelegateModel.inSelected
                    }
                }

                // 状态：选中、普通
                states: [
                    State {
                        name: "selected"
                        ParentChange { target: content; parent: selectionContainer; x: 3; y: 3 }
                        PropertyChanges { target: packageRoot; DelegateModel.inItems: visibleContainer.drag.active }
                        PropertyChanges { target: gradientStart; color: "#017423" }
                        PropertyChanges { target: gradientStart; color: "#007423" }
                    }, State {
                        name: "visible"
                        PropertyChanges { target: packageRoot; DelegateModel.inItems: true }
                        ParentChange { target: content; parent: visibleContainer; x: 3; y: 3 }
                        PropertyChanges { target: gradientStart; color: "#8AC953" }
                        PropertyChanges { target: gradientStart; color: "#8BC953" }
                    }
                ]
                transitions: Transition {
                    PropertyAction { target: packageRoot; properties: "DelegateModel.inItems" }
                    ParentAnimation {
                        target: content
                        NumberAnimation { target: content; properties: "x,y"; duration: 500 }
                    }
                    ColorAnimation { targets: [gradientStart, gradientEnd]; duration: 500 }
                }
            }
        }
    }
}
