import QtQuick 2.0

/**
属性绑定测试
- 什么时候是绑定的: 属性中写表达式；Qt.binding()方法
- 什么时候只是赋值：js中写表达式
*/
Item {
    id: root
    width: 500
    height: 500

    // 示例一：属性绑定和赋值
    Rectangle {
        anchors.centerIn: parent
        width: parent.width/2   // 绑定
        height: width * 0.6     // 绑定
        color: 'red'
        opacity:0.5
        focus: true
        MouseArea{
            anchors.fill: parent
            onClicked: parent.height = parent.width * 1.2  // 赋值。赋值语句成功后,绑定逻辑废除
        }
    }

    // 示例二：用绑定表达式
    Rectangle {
        id: rect
        width: 100
        color: "yellow"
    }
    Component.onCompleted: {
        rect.height = Qt.binding(function() { return root.height * 0.8 })
    }
}
