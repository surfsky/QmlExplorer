import QtQuick 2.0

/**
带文字的按钮
- 居中文字
- 自适应文字宽度
- 鹅软石圆角渐变外观
- 点击变化背景色
*/
Rectangle {
    id: container

    property alias text: label.text
    signal clicked

    width: label.width + 20;
    height: label.height + 6
    antialiasing: true
    radius: 10

    gradient: Gradient {
        GradientStop { id: gradientStop; position: 0.0; color: "#eeeeee" }
        GradientStop { position: 1.0; color: "#888888" }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: { container.clicked() }
    }
    Text {
        id: label
        anchors.centerIn: parent
        text: 'Button'
    }
    states: State {
        name: "pressed"
        when: mouseArea.pressed
        PropertyChanges { target: gradientStop; color: "#333333" }
    }
}
