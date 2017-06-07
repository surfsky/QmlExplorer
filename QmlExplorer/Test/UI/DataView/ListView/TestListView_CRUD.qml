import QtQuick 2.3
import QtQuick.Controls 1.2
import "../../../Controls/Button"


/**
ListView CRUD示例。改自官方示例listview/dynamiclist.qml
ListView所有增删改操作都直接操作model，由model去影响界面
    移动
        fruitModel.move(index, index-1, 1)
        fruitModel.move(index, index+1, 1)
    修改
        fruitModel.setProperty(index, "cost", cost + 0.25)
    删除
        fruitModel.remove(index)
    新增
        fruitModel.append({
            "name": "Pizza Margarita",
            "cost": 5.95,
            "attributes": [{"description": "Cheese"}, {"description": "Tomato"}]
        });
    清空
        fruitModel.clear()
动画（增加删除）
    ListView.onAdd: SequentialAnimation {
        PropertyAction { target: delegateItem; property: "height"; value: 0 }
        NumberAnimation { target: delegateItem; property: "height"; to: 80; duration: 250; easing.type: Easing.InOutQuad }
    }
    ListView.onRemove: SequentialAnimation {
        PropertyAction { target: delegateItem; property: "ListView.delayRemove"; value: true }
        NumberAnimation { target: delegateItem; property: "height"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
        PropertyAction { target: delegateItem; property: "ListView.delayRemove"; value: false }
    }
**/
Rectangle {
    id: container
    width: 500; height: 400
    color: "#343434"


    //------------------------------------------
    // 增加、清除按钮
    //------------------------------------------
    Row {
        id: buttons
        x: 20
        y: 20
        width: parent.width
        height: 20
        spacing: 10
        TextButton {
            text: "Add an item"
            onClicked: {
                fruitModel.append({
                    "name": "Pizza Margarita",
                    "cost": 5.95,
                    "attributes": [{"description": "Cheese"}, {"description": "Tomato"}]
                })
            }
        }
        TextButton {
            text: "Remove all items"
            onClicked: fruitModel.clear()
        }
    }



    //------------------------------------------
    // listview
    //------------------------------------------
    ListView {
        id: listView
        anchors {
            left: parent.left; top: buttons.bottom;
            right: parent.right; bottom: parent.bottom;
            margins: 20
        }
        model: fruitModel
        delegate: listDelegate
        clip: true
    }




    //-----------------------------------------
    // model
    // 把attributes改成数组（未完成）
    //-----------------------------------------
    ListModel {
        id: fruitModel
        Component.onCompleted: {
            append([
               {
                   "name": "Apple",
                   "cost": 2.45,
                   "attributes": [{"description": "Core"}, {"description": "美味"}]
                   //"attributes": ["Core", "美味"]  // 如何绑定到数组
               },
               {
                   "name": "Banana",
                   "cost": 1.95,
                   "attributes": [{"description": "产于热带"}, {"description": "无核"}]
               },
               {
                   "name": "Cumquat",
                   "cost": 3.25,
                   "attributes": [{"description": "柑橘类"}]
               },
               {
                   "name": "Durian",
                   "cost": 9.95,
                   "attributes": [{"description": "产于热带"}, {"description": "难闻"}]
               }
           ]);
        }
    }

    // 行数据UI
    Component {
        id: listDelegate
        Rectangle {
            //border.width: 1
            //border.color: '#808080'
            color: 'transparent'
            id: delegateItem
            width: listView.width;
            height: 40    // 这个高度很难控制
            clip: true

            // 模型数据
            Column {
                id: itemData
                x: 10
                width: 150
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    height: 20
                    text: name
                    font.pixelSize: 15
                    font.bold: true
                    color: "white"
                }
                Row {
                    width: 200
                    height: 20
                    spacing: 5
                    Repeater {
                        model: attributes
                        Text { text: description; color: "White" }
                    }
                }
            }
            // 价格、调整
            Row {
                id: itemPrice
                //x: 120
                width: 200
                height: 20
                spacing: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: itemData.right
                ImageButton {
                    source: "pics/plus-sign.png"
                    onClicked: fruitModel.setProperty(index, "cost", cost + 0.25)
                }
                Text {
                    id: costText
                    text: '$' + Number(cost).toFixed(2)
                    font.pixelSize: 15
                    color: "white"
                    font.bold: true
                }
                ImageButton {
                    source: "pics/minus-sign.png"
                    onClicked: fruitModel.setProperty(index, "cost", Math.max(0,cost-0.25))
                }
            }

            // 删除、排序
            Row {
                width: 60
                height: 20
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                }
                ImageButton {
                    source: "pics/list-delete.png"
                    onClicked: fruitModel.remove(index)
                }
                Item{
                    height: 10
                    width:btnDown.width
                    ImageButton {
                        id: btnDown
                        source: "pics/arrow-down.png"
                        onClicked: fruitModel.move(index, index+1, 1)
                        visible: index!=fruitModel.count-1
                    }
                }
                Item{
                    height: 10
                    width: btnUp.width
                    ImageButton {
                        id: btnUp
                        source: "pics/arrow-up.png"
                        onClicked: fruitModel.move(index, index-1, 1)
                        visible: index!=0
                    }
                }
            }

            // 增加删除动画（不知道排序动画怎么做）
            ListView.onAdd: SequentialAnimation {
                PropertyAction { target: delegateItem; property: "height"; value: 0 }
                NumberAnimation { target: delegateItem; property: "height"; to: 80; duration: 250; easing.type: Easing.InOutQuad }
            }
            ListView.onRemove: SequentialAnimation {
                PropertyAction { target: delegateItem; property: "ListView.delayRemove"; value: true }
                NumberAnimation { target: delegateItem; property: "height"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
                // Make sure delayRemove is set back to false so that the item can be destroyed
                PropertyAction { target: delegateItem; property: "ListView.delayRemove"; value: false }
            }
        }
    }
}

