import QtQuick 2.0

Rectangle {
    width: 100
    height: 62
    color: 'lightblue'


    ToolTip {
        id: tooltip
        width: 300    //default width is 150px. and height is calculate automatically using the text size.
        backgroundColor: "yellow"     //set the background color
        textColor: "blue"       //set the text colour
        font.pointSize: 18    //You can use all font settings to set custom font.
        text: "Some <b>text</b> <i>here</i>";  //You can use HTML tags in text.
    }
}


/**
nokie的老组件示例
Rectangle {
     id: rectangle
     anchors.centerIn: parent
     width: 50
     height: 50
     color: "white"

     ToolTip {
         id: toolTip
         text: "ToolTip"
         target: rectangle
         visible: mouseArea.pressed
     }

     MouseArea {
         id: mouseArea
         anchors.fill: parent
     }
}



*/
