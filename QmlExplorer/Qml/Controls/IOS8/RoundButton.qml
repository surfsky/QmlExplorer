import QtQuick 2.0
import QtMultimedia 5.0

/**
ios 7/8风格按钮
*/
Rectangle {
    id: root
    radius: height/2
    height: 50
    width: txt.contentWidth + height

    // 属性
    property alias text : txt.text
    property color textColor : '#18a754'
    property alias textSize: txt.font.pixelSize
    property bool  selected: false
    color: area.pressed ? (selected ? 'white' : textColor) : (selected ? textColor : 'white')

    // 点击事件
    signal clicked(var mouse);
    signal pressed(var mouse);
    signal exited(var mouse);

    // 文字
    Text{
        id: txt
        smooth: true
        anchors.centerIn: parent
        text: 'Button'
        color: area.pressed ? (selected ? textColor : 'white') : (selected ? 'white' : textColor)
        font.pixelSize: root.height * 4/5
    }

    // 点击区域
    MouseArea {
        id: area
        anchors.fill: parent
        anchors.margins: -10
        onClicked: root.clicked(mouse);
        onPressed: root.pressed(mouse);
        onExited: root.exited(mouse);
    }
}
