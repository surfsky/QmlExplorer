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
        opacity: 1
        Behavior on opacity {
            NumberAnimation { properties:"opacity"; duration:5000 }
        }
        Image{
            id: back
            source: "Image/pic1.png"
            opacity: 1

            Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration:5000 }
            }
            MouseArea { anchors.fill: parent; onClicked: {stars.visible = true;
                    stars1.visible = true;stars2.visible = true;stars3.visible = true;stars4.visible = true;stars5.visible = true;
                    explode = true;
                    back.destroy(10000)}}
            states: State { name: "exploding"; when: explode == true
                // StateChangeScript {script: particles.burst(2000)}
                PropertyChanges { target: back; opacity: 0 }
                PropertyChanges { target: front; opacity: 1 }
                PropertyChanges { target: stars; opacity: 0 }
                PropertyChanges { target: stars1; opacity: 1 }
                PropertyChanges { target: stars2; opacity: 1 }
                PropertyChanges { target: stars3; opacity: 1 }
                PropertyChanges { target: stars4; opacity: 1 }
                PropertyChanges { target: stars5; opacity: 1 }
            }
            Particles {
                id: stars
                visible:false
                x: 0; y: 0; width: 360; height: 100
                source: "Image/rose.png"
                //angle:360
                //angleDeviation: 360
                //velocity: 0; velocityDeviation: 0
                fadeInDuration : 1000
                fadeOutDuration : 2000
                //opacity: 0.5
                emissionRate:20
                emissionVariance:1
                //width: 1
                //height: 1
                //source: "Image/rose.png"
                lifeSpan: 5000
                //lifeSpanDeviation:500
                count: 15
                rotation: 10
                transform: Scale { origin.x: 25; origin.y: 25; xScale: 1}
                angleDeviation: 360
                velocity: 0; velocityDeviation: 0
                //count: parent.width/2
                //fadeInDuration: 2800
                opacity: 1
                Behavior on opacity {
                    NumberAnimation { properties:"opacity"; duration:5000 }
                }
                // angle: 360
                //angleDeviation: 450
                //velocity: 50
                //velocityDeviation: 50
                //ParticleMotionGravity {
                //yattractor: 1
                //xattractor: 1
                //acceleration: 0
            }
            Particles {
                lifeSpan: 10000; lifeSpanDeviation: 1000
                id: stars1
                x: 0; y: 0; width: parent.width; height: parent.height
                source: "Image/meigui1.PNG"
                emissionRate:30
                angle: 90
                angleDeviation: 80
                visible:false
                velocity: 50; velocityDeviation: 30
                count: 3
                fadeInDuration: 3000
                opacity: 0
                Behavior on opacity {
                    NumberAnimation { properties:"opacity"; duration:5000 } }
                z:10
                ParticleMotionWander {
                    xvariance: 80
                    pace: 150
                }}
            Particles {
                lifeSpan: 10000; lifeSpanDeviation: 1000
                id: stars2
                x: 0; y: 0; width: parent.width; height: parent.height
                source: "Image/meigui2.PNG"
                emissionRate:30
                angle: 90
                angleDeviation: 80
                visible:false
                velocity: 50; velocityDeviation: 30
                count: 2
                fadeInDuration: 3000
                opacity: 0
                Behavior on opacity {
                    NumberAnimation { properties:"opacity"; duration:5000 } }
                z:10
                ParticleMotionWander {
                    xvariance: 80
                    pace: 150
                }}
            Particles {
                lifeSpan: 10000; lifeSpanDeviation: 1000
                id: stars3
                x: 0; y: 0; width: parent.width; height: parent.height
                source: "Image/meigui3.PNG"
                emissionRate:30
                angle: 90
                angleDeviation: 80
                visible:false
                velocity: 50; velocityDeviation: 30
                count: 3
                fadeInDuration: 3000
                opacity: 0
                Behavior on opacity {
                    NumberAnimation { properties:"opacity"; duration:5000 } }
                z:10
                ParticleMotionWander {
                    xvariance: 80
                    pace: 150
                }}
            Particles {
                lifeSpan: 10000; lifeSpanDeviation: 1000
                id: stars4
                x: 0; y: 0; width: parent.width; height: parent.height
                source: "Image/meigui4.PNG"
                emissionRate:30
                angle: 90
                angleDeviation: 80
                visible:false
                velocity: 50; velocityDeviation: 30
                count: 4
                fadeInDuration: 3000
                opacity: 0
                Behavior on opacity {
                    NumberAnimation { properties:"opacity"; duration:5000 } }
                z:10
                ParticleMotionWander {
                    xvariance: 80
                    pace: 150
                }}
            Particles {
                lifeSpan: 10000; lifeSpanDeviation: 1000
                id: stars5
                x: 0; y: 0; width: parent.width; height: parent.height
                source: "Image/meigui5.PNG"
                emissionRate:30
                angle: 90
                angleDeviation: 80
                visible:false
                velocity: 50; velocityDeviation: 30
                count: 5
                fadeInDuration: 3000
                opacity: 0
                Behavior on opacity {
                    NumberAnimation { properties:"opacity"; duration:5000 } }
                z:10
                ParticleMotionWander {
                    xvariance: 80
                    pace: 150
                }}

        }

    }
    Rectangle {
        id: toolBar
        width: parent.width; height: 40
        anchors.bottom: parent.bottom
        AnimatedImage { id: animation; x: 0; y: 0; anchors.rightMargin: 0; anchors.bottomMargin: 0; anchors.leftMargin: 0; anchors.topMargin: 0; source: "Image/4.gif" ;playing :true
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
                stars1.visible = true;stars2.visible = true;stars3.visible = true;stars4.visible = true;stars5.visible = true;
                explode = true;
            }
        }
    }
}
