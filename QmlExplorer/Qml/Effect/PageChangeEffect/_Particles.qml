import QtQuick 2.0
import QtQuick.Particles 2.0

ParticleSystem {
    property alias source: particle.source

    property alias emissionRate: emitter.emitRate
    property alias lifeSpan: emitter.lifeSpan
    property alias lifeSpanDeviation: emitter.lifeSpanVariation
    property alias velocity: emitter.velocity

    property int angle: 0   // 粒子发射角度
    property int angleDeviation: 360;  // 角度偏差
    property int velocityDeviation: 30   // 速度偏差


    // 效果A
    ImageParticle {
        id: particle
        anchors.fill: parent
        source: "qrc:///particleresources/star.png"
        color:"#FF1010"
        redVariation: 0.8
    }
    Emitter {
        id: emitter
        emitRate: 100
        lifeSpan: 2800
        size: 32
        sizeVariation: 8
        velocity: PointDirection{ x: 66; xVariation: 20 }
        width: 80
        height: 80
    }
    Affector {
        id: affector
        x: 120
        width: 80
        height: 80
        once: true
        position: PointDirection { x: 120; }
    }
}
