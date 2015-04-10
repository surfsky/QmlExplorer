import QtQuick 2.1
import QtQuick.Controls 1.0


/**
树控件
作者：surfsky.cnblogs.com 2014-10
协议：MIT 请保留本文档说明
功能
    /递归树显示
    /左侧一个箭头，点击可展开显示子树
    /选中节点变色
    /节点点击事件
    /tag属性，携带类似id的数据
    异步方式，点击箭头后请求子数据。异步模式的话，节点要加上isLeaf属性，点击箭头后动态加载数据
使用
    TreeView {
        anchors.fill: parent
        id: tree
        model: modelTree2
        onSelectedItemChanged: console.log(item.text)
    }
    ListModel {
        id: modelTree2
        Component.onCompleted: {
            modelTree2.append([
                {title: "Node 1"},
                {title: "Node 2", items: [
                    {title: "Node 21", items:[
                      {title: "Node 211"},
                      {title: "Node 212"}
                      ]},
                    {title: "Node 22"}
                  ]
                },
                {title: "Node 3"}
            ]);
        }
    }
参考 http://qt-project.org/forums/viewthread/30521/
*/
ScrollView {
    id: view
    frameVisible: true
    implicitWidth: 200
    implicitHeight: 160

    // 输入属性
    property var model
    property int rowHeight: 19
    property int columnIndent: 22
    property string expanderImage : "expander.png";

    // 私有属性
    property var currentNode  // 当前节点数据
    property var currentItem  // 当前节点UI

    // 信号
    signal selectedItemChanged(var item)


    // 节点数据展示的UI
    property Component delegate: Label {
        id: label
        text: model.title ? model.title : 0
        color: currentNode === model ? "white" : "black"
        property var tag : model.tag
    }

    //
    contentItem: Loader {
        id: content
        onLoaded: item.isRoot = true
        sourceComponent: treeBranch
        property var items: model

        // 背景条纹
        Column {
            anchors.fill: parent
            Repeater {
                model: 1 + Math.max(view.contentItem.height, view.height) / rowHeight
                Rectangle {
                    objectName: "Faen"
                    color: index % 2 ? "#eee" : "white"
                    width: view.width ; height: rowHeight
                }
            }
        }

        // 树节点组件
        Component {
            id: treeBranch
            Item {
                id: root
                property bool isRoot: false
                implicitHeight: column.implicitHeight
                implicitWidth: column.implicitWidth
                Column {
                    id: column
                    x: 2
                    Item { height: isRoot ? 0 : rowHeight; width: 1}
                    Repeater {
                        model: items
                        Item {
                            id: filler
                            width: Math.max(loader.width + columnIndent, row.width)
                            height: Math.max(row.height, loader.height)
                            property var _model: model
                            // 当前行背景色块
                            Rectangle {
                                id: rowfill
                                x: view.mapToItem(rowfill, 0, 0).x
                                width: view.width
                                height: rowHeight
                                visible: currentNode === model
                                color: "#37f"
                            }
                            // 行点击响应区域
                            MouseArea {
                                anchors.fill: rowfill
                                onPressed: {
                                    currentNode = model
                                    currentItem = loader
                                    forceActiveFocus()
                                    selectedItemChanged(model);
                                }
                            }
                            // 行数据UI
                            Row {
                                id: row
                                // 行图标
                                Item {
                                    width: rowHeight
                                    height: rowHeight
                                    opacity: !!model.items ? 1 : 0
                                    Image {
                                        id: expander
                                        source: view.expanderImage
                                        height: view.rowHeight * 0.6
                                        fillMode: Image.PreserveAspectFit
                                        opacity: mouse.containsMouse ? 1 : 0.7
                                        anchors.centerIn: parent
                                        rotation: loader.expanded ? 90 : 0
                                        Behavior on rotation {NumberAnimation { duration: 120}}
                                    }
                                    MouseArea {
                                        id: mouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: loader.expanded = !loader.expanded
                                    }
                                }
                                // 行文本
                                Loader {
                                    property var model: _model
                                    sourceComponent: delegate
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            // 子树（递归自身）
                            Loader {
                                id: loader
                                x: columnIndent
                                height: expanded ? implicitHeight : 0
                                property var node: model
                                property bool expanded: false
                                property var items: model.items
                                property var text: model.title
                                sourceComponent: (expanded && !!model.items) ? treeBranch : undefined
                            }
                        }
                    }
                }
            }
        }
    }
}
