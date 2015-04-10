import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.XmlListModel 2.0



/**
可视数据模型（VisualDataModel)
DelegateModel 包含一个model和一个delegate，等同于 VisualDataModel
后者出于兼容性保存
import空间不同
*/
Flow {
    width: 640
    height: 480


    // 可视数据模型（包含一个模型和一个显示代理）
    VisualDataModel{
        id: fluits
        model: ListModel {
            ListElement {name: "Apple"; cost: 2.45}
            ListElement {name: "Orange"; cost: 3.25}
            ListElement {name: "Banana"; cost: 1.95}
        }
        delegate: Row {
            Text { text: "Name: " + name}
        }
    }

    ListView {
        width: 200; height: 100
        model: fluits
    }
}
