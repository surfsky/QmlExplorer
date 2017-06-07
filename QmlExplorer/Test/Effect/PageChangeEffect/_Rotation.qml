import QtQuick 2.3
import QtQuick.Particles 2.0

Rectangle {
    id: page
    property bool explode : false
    width: 360; height: 680;
    SystemPalette { id: activePalette }

    Image {
        id: back
        source: "Image/pic2.png"
    }

    Item{
        id: frontpage
        width: parent.width
        height: 640
        //anchors { top: parent.top; bottom: toolBar.top }
        Image{
            id: front
            anchors.fill: parent
            source: "Image/pic1.png"

        }
        Behavior on x {
            NumberAnimation { properties:"x"; duration: 1000 }
        }
        Behavior on y {
            NumberAnimation { properties:"y"; duration: 1000 }
        }
        Behavior on width {
            NumberAnimation { properties:"width"; duration: 1000 }
        }
        Behavior on height {
            NumberAnimation { properties:"height"; duration: 1000 }
        }

        Behavior on rotation {
            NumberAnimation { properties:"rotation"; from: 0; duration: 1000 }
        }

        MouseArea { anchors.fill: parent; onClicked: explode = true }
    }
    Rectangle {
       id: toolBar
       width: parent.width; height: 40
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
           width: 62; height: 27
           anchors { verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
           //Text:{text: "Switch"}
           text: "Play"
           onClicked: explode = true
       }
    }

     states: State {
          name: "moved";
          when: explode == true
          PropertyChanges { target: frontpage; width: 0 }
          PropertyChanges { target: frontpage; height: 0 }
          PropertyChanges { target: frontpage; x: 180 }
          PropertyChanges { target: frontpage; y: 320 }
          //PropertyChanges { target: front; opacity: 0 }
          PropertyChanges { target: frontpage; rotation: 1020 }

     }


}
