import QtQuick 2.0
import QtQuick.Particles 2.0

/**
测试粒子效果
ParicleSystm
    Particle
    Emmiter
    Affector
*/
ParticleSystem
{
    width: 500
    height: 500
    anchors.centerIn: parent
    ImageParticle
    {
        source: "qrc:///particleresources/fuzzydot.png"
        colorVariation: 1.0
    }

    Emitter
    {
        emitRate: 20
        size: 10
        lifeSpan: 4000
        velocity: AngleDirection
        {
            magnitude: 100
            angleVariation: 360
        }
        x:parent.width/2
        y:parent.height*1/3
    }

    Gravity
    {
        angle: 90
        magnitude: 100
    }
}
