import QtQuick 2.0
import QtQuick.Controls 1.2


/*模型 CRUD 测试*/
Column {
    width: 600
    height: 400
    spacing: 10

    //----------------------------
    // 控制区
    //----------------------------
    Row{
        spacing: 5
        Button{text: 'Get';    onClicked: lbl.text = model.get(0).name;}
        Button{text: 'Add';    onClicked: model.append({name: "Apple", cost: 2.45});}
        Button{text: 'Modify'; onClicked: model.setProperty(0, 'cost', 9.99);}
        Button{text: 'Delete'; onClicked: model.remove(0);}
        Button{text: 'Clear';  onClicked: model.clear();}
        Text{id: lbl}
    }

    //----------------------------
    // model & view
    //----------------------------
    ListModel {
        id: model
        ListElement {name: "Apple"; cost: 2.45}
        ListElement {name: "Orange"; cost: 3.25}
        ListElement {name: "Banana"; cost: 1.95}
    }
    ListView{
        width: 200; height: 100
        model: model
        delegate: Text {
            text: name + ": " + cost
        }
    }
}

