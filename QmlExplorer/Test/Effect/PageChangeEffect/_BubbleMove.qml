import QtQuick 2.3
import QtQuick.Particles 2.0

Rectangle {
    id: page
    width: 360; height: 680;
    color: "black"
    property bool explode : false
         Image {
             id: front
             source: "Image/pic2.png"
             opacity: 0

             Behavior on opacity {
                     NumberAnimation { properties:"opacity"; duration:4000 }
                 }
}
             Image{
                 id: back
                 source: "Image/pic1.png"
                 opacity: 1

                 Behavior on opacity {
                         NumberAnimation { properties:"opacity"; duration:4000 }
                     }
    }

     // 这些都是老的代码，qt5.x已经将particles拆分成emitter、particlesystem等元素
     Particles {
        lifeSpan: 1000; lifeSpanDeviation: 600
        id: stars

        x: 0; y: 0; width: parent.width; height: parent.height
        source: "Image/bubble1.PNG"
        visible:false
        angleDeviation: 360
        velocity: 50; velocityDeviation: 10
        count: 9
        fadeInDuration: 3000
        opacity: 1
        Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration:5000 }
            }
        z:10

    }
     Particles {
        lifeSpan: 1000; lifeSpanDeviation: 600
        id: stars1
        x: 0; y: 0; width: parent.width; height: parent.height
        source: "Image/bubble2.PNG"
        visible:false
        angleDeviation: 360
        velocity: 50; velocityDeviation: 10
        count: 9
        fadeInDuration: 3000
        opacity: 1
        Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration:5000 }
            }
        z:10
    }
     Particles {
        lifeSpan: 1000; lifeSpanDeviation: 600
        id: stars2
        x: 0; y: 0; width: parent.width; height: parent.height
        source: "Image/bubble3.PNG"
        visible:false
        angleDeviation: 360
        velocity: 50; velocityDeviation: 10
        count: 9
        fadeInDuration: 3000
        opacity: 1
        Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration:5000 }
            }
        z:10
    }
     Rectangle {
        id: toolBar
        width: parent.width; height: 40
        anchors.bottom: page.bottom
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
            //Text:{text: "Switch"}
            width: 62; height: 27
            text: "Play"
            onClicked:  {
                stars.visible = true;
                stars1.visible= true;
                stars2.visible = true;
                stars3.visible = true;
                explode = true;
            }
        }
     }
    states: State { name: "exploding"; when: explode == true
        //StateChangeScript {script: particles.burst(200)}

        PropertyChanges { target: back; opacity: 0 }
        PropertyChanges { target: front; opacity: 1 }
         PropertyChanges { target: stars; opacity: 0 }
          PropertyChanges { target: stars1; opacity: 0 }
           PropertyChanges { target: stars2; opacity: 0 }
    }
    MouseArea { anchors.fill: parent;
        onClicked: {stars.visible = true;
            stars1.visible= true;stars2.visible = true
            explode = true;
            //Component.onCompleted=back.destroy(3900)
            back.destroy(3900)


        }
}}
