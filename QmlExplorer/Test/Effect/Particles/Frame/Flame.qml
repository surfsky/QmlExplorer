import QtQuick 2.0
import QtQuick.Particles 2.0


 /*
粒子示例
    // 定义了5个可触摸点
    MultiPointTouchArea {
        anchors.fill: parent
        minimumTouchPoints: 1
        maximumTouchPoints: 5
        touchPoints: [
            TouchPoint { id: touch1 },
            TouchPoint { id: touch2 },
            TouchPoint { id: touch3 },
            TouchPoint { id: touch4 },
            TouchPoint { id: touch5 }
        ]
    }

    // 5个触摸点点击后会出现火焰粒子
    Flame{ color: 'red';    point: touch1;  enabled: touch1.pressed}
    Flame{ color: 'green';  point: touch2;  enabled: touch1.pressed}
    Flame{ color: 'blue';   point: touch3;  enabled: touch1.pressed}
    Flame{ color: 'yellow'; point: touch4;  enabled: touch1.pressed}
    Flame{ color: 'violet'; point: touch5;  enabled: touch1.pressed}
*/
ParticleSystem{
    anchors.fill: parent
    property alias image: img.source
    property alias color : img.color
    property TouchPoint point
    property alias enabled : emitter.enabled


    ImageParticle{
        id: img
        source: 'images/heart.png'
        colorVariation: 0.1
        color: '#ff521d'
        alpha: 0
    }

    Emitter{
        id: emitter
        x: point.x
        y: point.y
        velocityFromMovement: 10
        emitRate: 80
        lifeSpan: 1500
        velocity: PointDirection{y:-90; yVariation: 50}
        acceleration: PointDirection{xVariation: 100; yVariation: 90}
        size: 51
        sizeVariation: 53
        endSize: 64
    }


}
