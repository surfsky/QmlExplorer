import QtQuick 2.3
import "initializeBlock.js" as SwitchPage

Rectangle {
    id: screen
    width: 360
    height: 680
    Image {
        id:nextpage
        source: "Image/pic2.png"
    }

    SystemPalette { id: activePalette }

    Item{

        width: parent.width
        height: parent.height
        anchors { top: parent.top; bottom: toolBar.top }
        Image {
            id: background
            //anchors.fill: parent
            source: "Image/pic1.png"
            fillMode: Image.PreserveAspectCrop
            opacity: 1

            Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration: 1000 }
            }
        }

    }
    Rectangle {
       id: toolBar
       width: parent.width; height: 40
       color: "gray"
       anchors.bottom: parent.bottom
       AnimatedImage { id: animation; source: "Image/4.gif" ;playing :true
           anchors.fill:parent}
       Rectangle {
                    property int frames: animation.frameCount
                    //width: parent.width; height: parent.height
                    //x:140
                    x: (animation.width - width) * animation.currentFrame / frames
                    y: root.height}


       Button2 {
           anchors { verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
           width: 62; height: 27
           text: "Play"
           onClicked: SwitchPage.initializeBlock()
       }
    }
}
