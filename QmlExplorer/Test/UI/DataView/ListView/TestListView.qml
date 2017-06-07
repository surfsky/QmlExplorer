import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1


/**
列表视图基础示例（更详细的数据模型请参考 TestModel_XXX 相关示例）
*/
Flow {
    width: 640
    height: 480

    // listview基础示例
    ListView{
        width: parent.width*0.5
        height: 100
        model: ListModel {
            ListElement {name: "Apple"; cost: 2.45;}
            ListElement {name: "Orange"; cost: 3.25}
            ListElement {name: "Banana"; cost: 1.95}
        }
        delegate: Row{
            spacing: 5
            Text {text: index}
            Text {text: "<b>" + name + "</b>"}
            Text {text: "<i>" + cost + "</i>"}
        }
    }

    // list的元素是动态生成的
    ListView {
        width: parent.width*0.5
        height: 100
        model: 5
        delegate: Component {
            Loader {
                sourceComponent: Component {
                    Text { text: index }
                }
            }
        }
    }

    // list的元素是来自其他qml文件
    ListView {
        width: parent.width*0.5
        height: 100
        model: 5
        delegate: Component {
            Loader {
                source: "ListItem.qml"
            }
        }
    }
}
