import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: window
    width: 400
    height: 480
    title: qsTr("Tree")


    // 用listmodel
    ListModel {
        id: modelTree
        ListElement { title: "Node 1"; tag: 1}
        ListElement {
            title: "Node 2"
            tag: 2
            items: [
                ListElement { title: "Node 21"
                    items: [
                        ListElement { title: "Node 211" }
                    ]
                },
                ListElement { title: "Node 22" }
            ]
        }
        ListElement { title: "Node 3" }
    }

    // 或者用json
    ListModel {
        id: modelTree2
        Component.onCompleted: {
            modelTree2.append([
                {title: "Node 1", tag: 1},
                {title: "Node 2", tag: 2, items: [
                    {title: "Node 21", tag: 21, items:[
                      {title: "Node 211", tag: 211},
                      {title: "Node 212", tag: 212}
                      ]},
                    {title: "Node 22", tag: 22}
                  ]
                },
                {title: "Node 3"}
            ]);
        }
    }

    // tree
    TreeView {
        anchors.fill: parent
        id: tree
        model: modelTree2
        onSelectedItemChanged: console.log(item.tag)

        rowHeight: 30
        expanderImage: "arrow.png"
        //expanderImage: "trigle.png"
    }
}
