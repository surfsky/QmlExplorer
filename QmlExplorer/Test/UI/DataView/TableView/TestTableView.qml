import QtQuick 2.0
import QtQuick.Controls 1.1


/**
测试表格视图
可参考官方示例工程：tableview
*/
Rectangle {
    width: 640
    height: 480


    ListModel {
        id: libraryModel
        ListElement{ title: "A Masterpiece" ; author: "Gabriel" }
        ListElement{ title: "Brilliance"    ; author: "Jens" }
        ListElement{ title: "Outstanding"   ; author: "Frederik" }
    }

    TableView {
        anchors.fill: parent
        TableViewColumn{ role: "title"  ; title: "Title" ; width: 100 }
        TableViewColumn{ role: "author" ; title: "Author" ; width: 200 }
        model: libraryModel

        frameVisible: true
        headerVisible: true
        sortIndicatorVisible: true
        alternatingRowColors: true
    }
}
