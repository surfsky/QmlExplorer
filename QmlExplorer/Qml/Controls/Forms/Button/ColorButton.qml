/**
自定义按钮
- 可自定义文本，圆角、边框、各态的色彩
- 以后考虑将自定义背景图片也融合进去
注：QmlControls提供的Button会随着系统不同而不同，这不适合移植
*/
import QtQuick 2.0
Rectangle {
    // 新属性
    property string buttonText: "button"
    property color colorNormal: "lightblue"
    property color colorHover: "gold"
    property color colorPress: "lightgreen"
    property color colorBorder: "white"
    property color colorText: "black"
    signal buttonClick()

    // 可重载属性
    id: simplebutton
    width: 150;
    height: 75
    radius: 8
    color: colorNormal    //MouseArea.pressed ? colorPress : colorNormal
    border.color: colorBorder

    // 设置
    Text{
        id: buttonLabel
        anchors.centerIn: parent
        text: buttonText
        color: colorText
    }

    // 事件
    onButtonClick: {
        console.debug(buttonLabel.text + " clicked点击" )
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onPressed: parent.color = colorPress;
        onEntered: parent.color = colorHover
        onExited:  parent.color = colorNormal
        onClicked: {parent.color = colorHover; buttonClick();}
    }
}

