import QtQuick 2.0
import "../"


/**
ios8 群组按钮示例
    /属性：currentIndex
    封装成组件
        属性：texts:['1', '2', '3', '4']
        用repeater或listview实现
   竖分隔线
bug：
    有点偏差
**/
Rectangle {
    id: root
    width: 400
    height: 50
    radius: height/2
    border.color: '#18a754'
    border.width: 2
    clip: true
    antialiasing: true

    property int currentIndex:0
    property int cellWidth: (root.width-root.height)/3

    // 头
    Rectangle{
        id: header
        height: parent.height-2
        width: root.cellWidth + root.height/2
        anchors.verticalCenter: parent.verticalCenter
        x:0;
        clip: true
        color: 'transparent'
        RoundButton{
            height: parent.height-2
            width: root.cellWidth + root.height
            textSize: 20
            text: 'Choose 1'
            onClicked: root.currentIndex = 0;
            selected: root.currentIndex == 0;
        }
    }

    // 尾
    Rectangle{
        id: tailer
        height: parent.height-2
        width: root.cellWidth + root.height/2
        anchors.verticalCenter: parent.verticalCenter
        x:root.width-width;
        clip: true
        color: 'transparent'
        RoundButton{
            height: parent.height-2
            width: root.cellWidth + root.height
            x: -root.height/2
            textSize: 20
            text: 'Choose 3'
            onClicked: root.currentIndex = 2;
            selected: root.currentIndex == 2;
        }
    }
    // 中间
    RoundButton{
        height: parent.height-2
        width: root.width-header.width-tailer.width+1  //root.cellWidth
        anchors.verticalCenter: parent.verticalCenter
        x: root.cellWidth+height/2;
        text: 'Choose 2'
        textSize: 20
        radius: 0
        onClicked: root.currentIndex = 1;
        selected: root.currentIndex == 1;
        //border.color: root.border.color
    }
}
