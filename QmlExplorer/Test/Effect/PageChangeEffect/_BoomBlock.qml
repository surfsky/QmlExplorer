import QtQuick 2.3
import QtQuick.Particles 2.0
import "initializeBlock.js" as SwitchPage

Item {
    id: block

    property bool dying: false
    property bool spawned: false

    Behavior on x {
        enabled: spawned
        SpringAnimation{ spring: 2; damping: 0.2 }
    }
    Behavior on y {
        SpringAnimation{ spring: 2; damping: 0.2 }
    }
    Image {
        id: img
        anchors.fill: parent
        source: "Image/blueStone.png"
        opacity: 1
        Behavior on opacity {
            NumberAnimation { properties:"opacity"; duration: 3000 }
        }
    }


    Particles {
        id: particles
        width: 1; height: 1
        anchors.centerIn: parent

        emissionRate: 0
        lifeSpan: 5000;
        lifeSpanDeviation: 600
        angle: 0;
        angleDeviation: 360;
        velocity: 100;
        velocityDeviation: 30
        source: "Image/blueStar.png"
    }

    states: [
        State {
            name: "AliveState"
            when: spawned == true && dying == false
            StateChangeScript { script: particles.burst(30); }
            PropertyChanges { target: img; opacity: 0 }
            PropertyChanges { target: background; opacity: 0 }
            StateChangeScript { script: block.destroy(1000);}
        }
    ]
}
