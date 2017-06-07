import QtQuick 2.3
import QtQuick.Particles 2.0

Rectangle {
    id:root
    width: 360
    height: 680
    property bool explode : false
    SystemPalette { id: activePalette }
    Image {
        id: front
        source: "Image/pic2.png"
        opacity: 0

        Behavior on opacity {
            NumberAnimation { properties:"opacity"; duration:5000 }
        }
    }
    Image{
        id: back
        width: 360
        height: 640
        source: "Image/pic1.png"
        opacity: 1
        anchors.centerIn:front.Center

        Behavior on opacity {
            NumberAnimation { properties:"opacity"; duration: 5000 }
        }
        MouseArea {
            anchors.fill: parent;
            onClicked: {stars.visible = true;
                stars1.visible= true;
                stars2.visible = true;
                stars3.visible = true;
                //xx.running=true
                explode = true;
                //xx.running=true

            }
        }
        Particles {
            anchors.centerIn:parent
            id:stars
            visible:false
            y: 315
            x: 180
            source: "Image/star.png"
            lifeSpan: 5000
            emissionRate:1000
            count:20000
            angle: 360
            angleDeviation: 360
            velocity: 1000
            velocityDeviation: 1000
            fadeInDuration:500
            fadeOutDuration:500
        }
        Particles {
            anchors.centerIn:parent
            id:stars1
            visible:false
            y: 315
            x: 180
            width: 10
            height: 10
            source: "Image/bluestar2.png"
            lifeSpan: 5000
            emissionRate:1000
            count:20000
            angle: 360
            angleDeviation: 360
            velocity: -1
            velocityDeviation: 1000
            fadeInDuration:500
            fadeOutDuration:500
            RotationAnimation on rotation {
                easing.type: Easing.InOutBack;
                duration:10000
                loops: -1
                from: 0
                to: 360
            }
        }
        Particles {
            anchors.centerIn:parent
            id:stars2
            visible:false
            y: 315
            x: 180
            width: 10
            height: 10
            source: "Image/greenstar.png"
            lifeSpan: 5000
            emissionRate:1000
            count:20000
            angle: 360
            angleDeviation: 360
            velocity: -1
            velocityDeviation: 1000
            fadeInDuration:500
            fadeOutDuration:500
            RotationAnimation on rotation {
                easing.type: Easing.InOutBack;
                duration:10000
                loops: -1
                from: 0
                to: 360
            }
        }
        Particles {
            anchors.centerIn:parent
            id:stars3
            visible:false
            y: 315
            x: 180
            width: 10
            height: 10
            source: "Image/pstar.png"
            lifeSpan: 5000
            emissionRate:1000
            count:20000
            angle: 360
            angleDeviation: 360
            velocity: 500
            velocityDeviation: 1000
            fadeInDuration:500
            fadeOutDuration:500
            RotationAnimation on rotation {
                easing.type: Easing.InOutBack;
                duration:10000
                loops: -1
                from: 0
                to: 360
            }
        }

    }
    ParallelAnimation{
        id:xx
        running:false
        //NumberAnimation  {id :be1;  target: back;properties:"width"; to:back.width*30;duration: 2000 }
        //NumberAnimation { id:be2;target: back;properties:"height"; to:back.height*30;duration: 2000 }
        //NumberAnimation  {id :be3;  target: back;properties:"width"; to:back.width*10;duration: 1000 }
        //NumberAnimation { id:be4;target: back;properties:"height"; to:back.height*10;duration: 1000 }

        //NumberAnimation {id:be5; properties:"rotation"; from: 0; to:1300;duration: 1000 }
        //NumberAnimation  {id :be3;  target: back;properties:"y"; to:-front.y/2*20;duration: 2000}
        //NumberAnimation { id:be4;target: back;properties:"x"; to:-front.x/2*00;duration: 2000 }}
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
                stars2.visible = true;
                stars3.visible = true;
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
