import QtQuick 2.0
import QtQuick.Controls 1.1
import "../../../../js/qml.js" as Common

/**
测试 repeater
- 用于展示大量的数据
- 常与布局器（row/column）结合使用
- Repeater组件会将内部的模板重复生成到同级目录，并生成一个QQuickRepeater对象（无UI的东东）
    结构示例
        QQuickColumn(0x2c277b0), (0, 30, 60, 120, 11)
          QQuickText(0x5859518), (0, 0, 60, 12, 0)
          QQuickText(0x5859470), (0, 12, 60, 12, 0)
          QQuickText(0x5859338), (0, 24, 60, 12, 0)
          QQuickText(0x5859560), (0, 36, 60, 12, 0)
          QQuickText(0x58594e8), (0, 48, 60, 12, 0)
          QQuickText(0x58595f0), (0, 60, 60, 12, 0)
          QQuickText(0x5859668), (0, 72, 60, 12, 0)
          QQuickText(0x5859878), (0, 84, 60, 12, 0)
          QQuickText(0x5859818), (0, 96, 60, 12, 0)
          QQuickText(0x58596f8), (0, 108, 60, 12, 0)
          QQuickRepeater(0x57dfaa8), (0, 0, 0, 0, 0)
*/
Column {
    width: 640
    height: 480
    spacing: 10

    Row {
        Repeater {
            model: 10
            Rectangle {
                width: 20; height: 20; radius: 10; color: "green"
                Text {text: index; anchors.centerIn: parent; color: 'white'}
            }
        }
    }

    Column {
        id: container
        Repeater {
            model: 10
            Text { text: "I'm item " + index }
        }
    }

    // flickable嵌套column，无法拖动。。。
    Flickable{
        width: 500
        height: 50
        clip:true
        Column {
            width:500
            height:70
            Repeater {
                model: ["apples", "oranges", "pears", "oranges", "pears", "oranges", "pears"]
                Text { text: "Data: " + modelData ; height: 10}
            }
        }
    }

    Column{
        Repeater{
            width: 200;
            height: 100
            model: ListModel {
                id: contacts
                ListElement {name: "Bill Smith"; number: "555 3264"}
                ListElement {name: "John Brown"; number: "555 8426"}
                ListElement {name: "Sam Wise";   number: "555 0473"}
            }
            delegate: Column {
                Text { text: '<b>Name:</b> ' + name }
                Text { text: '<b>Number:</b> ' + number }
            }
        }
    }

    /**
    */
    Component.onCompleted: {
        Common.printChildren(container);
    }
}
