import QtQuick 2.3
import QtQuick.Particles 2.0


Rectangle {
    id: page
    property bool explode : false
    SystemPalette { id: activePalette }
    width: 360; height: 680
    Image {
        id: front
        source: "Image/pic2.png"
        Image{
            id: back
            source: "Image/pic1.png"
            opacity: 1
            Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration: 3000 }
            }
            Particles {
                lifeSpan: 1000;
                lifeSpanDeviation: 600
                id: stars
                visible:false
                x: 0; y: 0; width: parent.width; height: parent.height
                source: "Image/tornado.gif"
                angleDeviation: 360
                velocity: 0; velocityDeviation: 0
                count: parent.width/10
                fadeInDuration: 3000
                opacity: 0.4
                z:10
            }
            MouseArea { anchors.fill: parent; onClicked: {stars.visible= true; explode = true}
                //
            }
        }

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
            onClicked:  {stars.visible = true; explode = true;}
        }
    }
    states: State {
        name: "moved";
        when: explode == true
        PropertyChanges { target: back; opacity: 0 }
    }
}
