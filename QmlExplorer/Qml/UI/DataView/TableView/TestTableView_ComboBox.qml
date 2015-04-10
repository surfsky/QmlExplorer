import QtQuick 2.2
import QtQuick.Controls 1.2


/**
表格内嵌下拉框
**/
Rectangle {
    width: 800
    height: 480
    ListModel {
        id: fruitModel
        ListElement { name: "Apple"  }
        ListElement { name: "Orange"  }
        ListElement { name: "Banana"  }
    }
    TableView {
        id:tableview
        anchors.fill: parent
        model:fruitModel


        TableViewColumn { title: "first column" }
        TableViewColumn {
            role:"categoryName"
            title:"combo column"
            width: 100
            delegate: Item {
                ComboBox {
                    anchors.verticalCenter: parent.verticalCenter
                    model: ListModel {
                        ListElement {  text: "Veggies" }
                        ListElement {  text: "Fruits" }
                        ListElement {  text: "Cars"  }
                    }
                }
            }
        }
    }
}
