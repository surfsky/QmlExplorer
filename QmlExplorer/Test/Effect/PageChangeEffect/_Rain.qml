import QtQuick 2.3
import QtQuick.Particles 2.0
Rectangle {
    width: 360
    height: 680
    property bool explode : false
    SystemPalette { id: activePalette }
    Image {
        id: front
        source: "Image/pic2.png"
        opacity: 0
        Behavior on opacity {
            NumberAnimation { properties:"opacity"; duration: 3000 }
        }
    }
    Image{
        id: back
        source: "Image/pic1.png"
        opacity: 1
        Behavior on opacity {
            NumberAnimation { properties:"opacity"; duration: 3000 }
        }
        MouseArea { anchors.fill: parent;
            onClicked: {
                stars.visible = true;
                stars1.visible= true;stars2.visible = true
                lei.visible=true
                explode = true
            }
        }
        Particles {
            id:stars
            visible:false
            width: parent.width
            height: 300
            source: "Image/rain.png"
            lifeSpan: 900
            lifeSpanDeviation:300
            count: 50
            angle: 70
            angleDeviation: 36
            velocity: 30
            velocityDeviation: 10
            ParticleMotionGravity{
                yattractor: 2000
                xattractor: 0
                acceleration: 1000
            }
            RotationAnimation on rotation {
                easing.type: Easing.InOutBack;
                duration:10000
                loops: -1
                from: 0
                to: 30
            }
        }
        Particles {
            id:stars1
            visible:false
            width: parent.width
            height: 300
            source: "Image/rain2.png"
            lifeSpan: 900
            lifeSpanDeviation:400
            count: 50
            angle: 70
            angleDeviation: 36
            velocity: 30
            velocityDeviation: 10
            ParticleMotionGravity{
                yattractor: 2000
                xattractor: 0
                acceleration: 1000}
            RotationAnimation on rotation {
                easing.type: Easing.InOutBack;
                duration:10000
                loops: -1
                from: 0
                to: 30
            }
        }
        Particles {
            id:stars2
            visible:false
            width: parent.width
            height: 300
            source: "Image/rain3.png"
            lifeSpan: 900
            lifeSpanDeviation:500
            count: 50
            angle: 70
            angleDeviation: 36
            velocity: 30
            velocityDeviation: 10
            ParticleMotionGravity{
                yattractor: 2000
                xattractor: 0
                acceleration: 1000}
            RotationAnimation on rotation {
                easing.type: Easing.InOutBack;
                duration:10000
                loops: -1
                from: 0
                to: 30
            }
        }
        Particles {
            id:lei
            x:180
            y:0
            visible:false
            width: parent.width
            height: 300
            source: "Image/shandian.png"
            lifeSpan: 3000
            //lifeSpanDeviation:00
            count: 1
            angle: 0
            angleDeviation: 0
            velocity:-1
            velocityDeviation: 1
            opacity:1
            Behavior on opacity {
                NumberAnimation { properties:"opacity"; duration: 1000 }
            }
        }
    }
    Rectangle {
        id: toolBar
        width: parent.width; height: 40
        anchors.bottom: parent.bottom
        AnimatedImage { id: animation; source: "Image/4.gif" ;playing :true
            anchors.fill:parent}
        Button {
            width: 62   ; height: 27
            anchors { verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
            //Text:{text: "Switch"}
            text: "Play"
            onClicked:  { stars.visible = true;
                stars1.visible= true;stars2.visible = true;
                explode = true}
        }
    }
    states: State {
        name: "moved";
        when: explode == true
        PropertyChanges { target: back; opacity: 0 }
        PropertyChanges { target: front; opacity: 1 }
        PropertyChanges { target: lei; opacity: 0 }
    }
}

