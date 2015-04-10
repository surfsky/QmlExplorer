import QtQuick 2.2

/**
鼠标悬停有变色动画的按钮
有阴影边框
*/
Rectangle {
    // 属性
    property alias image: img.source
    property alias title: buttontext.text
    signal clicked()

    // basic
    id: button
    width: 100
    height: 40
    color: "lightgreen"


    // 文本和点击区域
    Text { id: buttontext; anchors.centerIn: parent; text: "Button"; font.pixelSize: 20 }
    MouseArea { id: mousearea; anchors.fill: parent; hoverEnabled: true; onClicked: button.clicked() }

    // 用九宫格图片
    BorderImage {
        id: img
        anchors {
            fill: button
            leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8
        }
        source: '../../../images/shadow.png'; smooth: true
        border.left: 10; border.top: 10; border.right: 10; border.bottom: 10
    }


    // 按键状态
    states: [
        State {
            name: "hover"
            when: mousearea.containsMouse && !mousearea.pressed
            PropertyChanges { target: button; color: "skyblue"}
            PropertyChanges { target: buttontext; font.bold: true}
        },
        State {
            name: "pressed"
            when: mousearea.pressed
            PropertyChanges { target: button; color: "yellowgreen"}
            PropertyChanges { target: buttontext; font.bold: true; color: "white"}
        }
    ]

    // 动画
    transitions: [
        Transition {
            to: "hover"
            ColorAnimation { duration: 500 }
        },
        Transition {
            from: "hover"; to: "pressed"
            ColorAnimation { duration: 300 }
        },
        Transition {
            to: ""
            ColorAnimation { duration: 500 }
        }
    ]
}
