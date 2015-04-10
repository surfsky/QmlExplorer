import QtQuick 2.0


/**
测试附加属性和信号
*/
Rectangle {
    width: 200; height: 200; color:'lightgrey'
    focus: true   // 这个必须加，否则不接收键盘事件

    // Component的附加信号处理
    Component.onCompleted: console.log("Completed Running!")
    Component.onDestruction: console.log("Destruction Beginning!")
    Rectangle {
        Component.onCompleted: console.log("Nested Completed Running!")
        Component.onDestruction: console.log("Nested Destruction Beginning!")
    }

    // 按键的附加信号处理
    Keys.onLeftPressed: console.log("left pressed")
    Keys.onRightPressed: console.log("right pressed")


    // ListView的附加属性
    // ps.说实话，这里设计得让人很费解。统一用item来描述会更容易理解
    //     ListView.isCurrentItem -> item.isCurrentItem
    //     index                  -> item.index
    ListView{
        anchors.fill: parent
        model: 20
        delegate: Component{
            Rectangle {
                width: parent.width;
                height: 30
                color: ListView.isCurrentItem ? 'lightgreen' : 'pink'  // ListView 附加属性
                Text {text: index; anchors.centerIn: parent}
            }
        }
    }
}
