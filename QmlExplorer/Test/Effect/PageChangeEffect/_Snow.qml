import QtQuick 2.3
import QtQuick.Particles 2.0

Rectangle {
    id: page
    width: 360; height: 680;
    property bool explode : false
    SystemPalette { id: activePalette }
    Image {
        id: front
        source: "Image/pic2.png"
        opacity: 0
        Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration: 5000 }
            }
    }
    Image{
        id: back
        source: "Image/pic1.png"
        opacity: 1
        Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration: 5000 }
            }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                stars.visible = true;
                stars1.visible= true;
                stars2.visible = true;
                stars3.visible = true;
                explode = true;
                back.destroy(5000)}
        }

        Particles {
           lifeSpan: 10000; lifeSpanDeviation: 1000
           id: stars
           x: 0; y: 0; width: parent.width; height: parent.height
           source: "Image/xuehua1.PNG"
           emissionRate:30
           visible:false
           angle: 90
           angleDeviation: 70
           velocity: 50
           velocityDeviation: 30
           count: parent.width/15
           opacity: 0.3
           z:10
           ParticleMotionWander {
            xvariance: 70
                        pace: 150
                    }
       }
        Particles {
           lifeSpan: 10000; lifeSpanDeviation: 1000
           id: stars1
           x: 0; y: 0; width: parent.width; height: parent.height
           source: "Image/xuehua1.PNG"
           visible:false
           angle: 90
           angleDeviation: 70
           emissionRate:30
           velocity: 50; velocityDeviation: 30
           count: parent.width/15
           fadeInDuration: 3000
           opacity: 0.5
           z:10
           ParticleMotionWander {
            xvariance: 80
                        pace: 150
                    }
       }
        Particles {
           lifeSpan: 10000; lifeSpanDeviation: 1000
           id: stars2
           x: 0; y: 0; width: parent.width; height: parent.height
           source: "Image/xuehua3.PNG"
           emissionRate:30
           angle: 90
           angleDeviation: 80
           visible:false
           velocity: 50; velocityDeviation: 30
           count: parent.width/15
           fadeInDuration: 3000
           opacity: 0.4
           z:10
           ParticleMotionWander {
            xvariance: 80
                        pace: 150
                    }
       }
        Particles {
           lifeSpan: 10000; lifeSpanDeviation: 1000
           id: stars3
           x: 0; y: 0; width: parent.width; height: parent.height
           source: "Image/xuehua4.PNG"
           emissionRate:30
           angle: 90
           angleDeviation: 80
           visible:false
           velocity: 50; velocityDeviation: 30
           count: parent.width/15
           fadeInDuration: 3000
           opacity: 0.4
           z:10
           ParticleMotionWander {
            xvariance: 80
                        pace: 150
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
           onClicked:  {
               stars.visible = true;
               stars1.visible= true;
               stars2.visible = true
               explode = true;
           }
       }
    }
    states: State {
        name: "moved";
        when: explode == true
        PropertyChanges { target: back; opacity: 0 }
        PropertyChanges { target: front; opacity: 1 }
    }

}
