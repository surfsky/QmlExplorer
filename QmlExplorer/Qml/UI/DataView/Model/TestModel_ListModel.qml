import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.XmlListModel 2.0



/**测试xml数据*/
Flow {
    width: 640
    height: 480
    spacing: 20




    //------------------------------------------
    // 水果列表-组合写法示例
    //------------------------------------------
    ListView{
        width: 200; height: 100
        model: ListModel {
            ListElement {name: "Apple"; cost: 2.45}
            ListElement {name: "Orange"; cost: 3.25}
            ListElement {name: "Banana"; cost: 1.95}
        }
        delegate: Text {
            text: name + ": " + cost
        }
    }


    //------------------------------------------
    // 联系人列表-数据和代理分离示例
    //------------------------------------------
    ListModel {
        id: contacts
        ListElement {name: "Bill Smith"; number: "555 3264"}
        ListElement {name: "John Brown"; number: "555 8426"}
        ListElement {name: "Sam Wise";   number: "555 0473"}
    }

    Component{
        id: contactsDelegate
        Column {
            Text { text: '<b>Name:</b> ' + name }
            Text { text: '<b>Number:</b> ' + number }
        }
    }

    ListView{
        width: 200; height: 100
        model: contacts;
        delegate: contactsDelegate
    }



    //------------------------------------------
    // 动态用js生成数据模型
    //------------------------------------------
    ListModel {
        id: contacts2
        Component.onCompleted: {
            append([
               {name: "Bill Smith", number: "555 3264"},
               {name: "John Brown", number: "555 8426"},
               {name: "Sam Wise",   number: "555 0473"}
               ]);
        }
    }
    ListModel {
        id: articles
        Component.onCompleted: {
            for (var i = 0 ; i < 100 ; ++i) {
                append({"index": i, "title": "A title " + i, "imagesource" :"http://someurl.com", "credit" : "N/A"})
            }
        }
    }
    ListView{
        width: parent.width; height: 100
        model: articles;
        delegate: Row{
            spacing: 5
            Text{ text: index}
            Text{ text: "<b>" + title + "</b>"}
            Text{ text: imagesource}
            Text{ text: credit}
        }
    }



    //------------------------------------------
    // 嵌套数据模型
    // TableView.itemDelegate.styleData 是比较奇葩和突兀的
    // 可参考官方示例工程：tableview
    //------------------------------------------
    ListModel {
        id: nestedModel
        ListElement{content: ListElement { description: "Core" ; color:"#ffaacc"}}
        ListElement{content: ListElement { description: "Second" ; color:"#ffccaa"}}
        ListElement{content: ListElement { description: "Third" ; color:"#ffffaa"}}
    }

    TableView {
        width: parent.width; height: 100
        model: nestedModel

        TableViewColumn {
            role: "content"
            title: "Text and Color"
            width: 220
        }

        itemDelegate: Item {
            Text {
                width: parent.width
                anchors.margins: 4
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                elide: styleData.elideMode
                text: styleData.value.get(0).description
                color: styleData.textColor
            }
            Rectangle{
                anchors.top:parent.top
                anchors.right:parent.right
                anchors.bottom:parent.bottom
                anchors.margins: 4
                width:32
                color: styleData.value.get(0).color
                border.color:"#666"
            }
        }
    }

}
