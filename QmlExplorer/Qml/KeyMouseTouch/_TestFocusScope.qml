import QtQuick 2.0
import QtQuick.Controls 1.1


/**
测试focusScope（可接受鼠标键盘聚焦）
众多QuickControl都继承自FocusScrope，可接受键盘tab跳转
textfield ： focusScope
textinput ： item
*/
Rectangle {
    width: 640
    height: 480

    FocusScope {
        anchors.centerIn: parent
        focus: true
        Grid{
            columns: 2
            spacing: 5

            Text{text:'TextField1'}
            Rectangle{
                width: 200; height:20
                radius: 4
                border.color: 'grey'
                border.width: 1
                TextField {
                    id: input
                    focus: true
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    text: "..."
                }
            }

            Text{text:'TextField2'}
            Rectangle{
                width: 200; height:20
                radius: 5
                border.color: 'grey'
                border.width: 1
                TextField {
                    id: input2
                    focus: false
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    text: "..."
                }
            }


            Text{text:'TextInput'}
            Rectangle{
                width: 200; height:20
                radius: 5
                border.color: 'grey'
                border.width: 1
                TextInput {
                    id: input3
                    focus: false
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    text: "..."
                }
            }
        }
    }
}

