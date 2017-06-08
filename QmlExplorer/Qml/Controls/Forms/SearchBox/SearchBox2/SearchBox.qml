/**
模拟实现搜索对话框
只是实现了外观，可优化：
- 回车键检测
- 弹出列表
*/
import QtQuick 2.3
FocusScope {
    property string defaultText : "请输入查询关键字";
    id: focusScope
    width: 250; height: 28

    // 背景边框
    BorderImage {
        source: "images/lineedit-bg.png"
        width: parent.width; height: parent.height
        border { left: 4; top: 4; right: 4; bottom: 4 }
    }

    // 水印文字、文本输入框、搜索图标
    Text {
        id: defaultInputText
        anchors.fill: parent; anchors.leftMargin: 8
        verticalAlignment: Text.AlignVCenter
        text: defaultText
        color: "gray"
        font.italic: true
    }
    TextInput {
        id: textInput
        anchors { left: parent.left; right: searchImg.left; leftMargin:8; rightMargin: 8; verticalCenter: parent.verticalCenter }
        focus: true
    }
    Image {
        id: searchImg
        source: "images/find16.png"
        anchors { right: parent.right; rightMargin: 8; verticalCenter: parent.verticalCenter }
    }

    // 是否输入了文字
    states:State {
        name: "hasText"
        when: textInput.text != ''
        PropertyChanges{ target: defaultInputText; opacity: 0 }
    }
    transitions: [
        Transition {
            from: ""
            to: "hasText"
            NumberAnimation { exclude: defaultInputText; properties: "opacity"}
        },
        Transition {
            from: "hasText"
            to: ""
            NumberAnimation {properties: "opacity"}
        }
    ]
}
