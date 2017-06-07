import QtQuick 2.0


/**
Package测试
一个package可容纳多个delegate展示
    - 用 Package.name 来区分
    - 用 model.parts.name 来调用
**/
Rectangle {
    id: root
    color: "white"
    width: 320
    height: 480
    property int upTo: 0
    SequentialAnimation on upTo {
        loops: -1
        NumberAnimation { to: 8; duration: 3500 }
        NumberAnimation { to: 0; duration: 3500 }
    }


    //-------------------------------------------------
    // 两个视图：listview、gridview使用同一个model的不同part
    //-------------------------------------------------
    ListView {
        id: lv
        height: parent.height/2
        width: parent.width
        model: visualModel.parts.list
    }
    GridView {
        y: parent.height/2
        height: parent.height/2
        width: parent.width
        cellWidth: width / 2
        cellHeight: 50
        model: visualModel.parts.grid
    }

    //-------------------------------------------------
    // 模型代理
    //-------------------------------------------------
    VisualDataModel {
        id: visualModel
        model: ListModel {
            ListElement { display: "One" }
            ListElement { display: "Two" }
            ListElement { display: "Three" }
            ListElement { display: "Four" }
            ListElement { display: "Five" }
            ListElement { display: "Six" }
            ListElement { display: "Seven" }
            ListElement { display: "Eight" }
        }
        delegate: PackageModel{}
    }

}
