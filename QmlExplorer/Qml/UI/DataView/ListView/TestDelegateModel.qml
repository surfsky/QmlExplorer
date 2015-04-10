import QtQuick 2.0

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
