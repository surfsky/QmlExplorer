import QtQuick 2.2

/*
提示组件
- 可设置文本：text, textColor, textSize
- 可设置三态色彩：normal, hover, click
- 自适应文本宽度
*/
Rectangle {
    id: root
    width: Math.max(height, text1.contentWidth+height)
    height: 40
    color: 'lightblue'
    radius: height/2

    // property
    property string colorNormal : 'lightblue'
    property string colorClicked: 'lightgreen'
    property string colorHover:   'orange'
    property alias text : text1.text
    property alias textColor : text1.color
    property alias textSize : text1.font.pixelSize

    // signal
    signal clicked(var mouse);

    // text
    Text {
        id : text1
        text: "12"
        color: "white"
        font.pixelSize: 18
        anchors.centerIn: parent
    }

    // MouseArea
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true                       // 允许鼠标悬停
        onEntered:  root.color = colorHover;     // 鼠标悬停
        onExited:   root.color = colorNormal;    // 鼠标离开
        onPressed:  root.color = colorClicked;   // 鼠标按下
        onReleased: root.color = colorNormal;    // 鼠标放开
        onClicked:  root.clicked(mouse);
    }
}
