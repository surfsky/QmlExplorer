
import QtQuick 2.0
import QtQuick.Particles 2.0

/*
测试粒子效果。
粒子系统包括三要素，并由ParticleSystem统一管理：
- 元素(Particle)：图像、色彩、色彩波动范围
    Particle
    Item
        ParticlePainter
            ItemParticle
            ImageParticle
            CustomParticle
- 发射器(Emitter)：图像的数目、大小、生命周期、方向等
- 影响因素(Affector)：位置、重力、加速度等
    Age,
    Attractor
    Friction
    Gravity
    GroupGoal
    SpriteGoal
    Turbulence
    Wander

更复杂的请参考partical官方示例
几个内置图像资源：
qrc:///particleresources/star.png
qrc:///particleresources/glowdot.png
qrc:///particleresources/fuzzydot.png
*/
Rectangle {
    width: 360
    height: 540
    color: "black"

    ParticleSystem {
        anchors.fill: parent


        //---------------------------------------------
        // 效果A
        //---------------------------------------------
        ImageParticle {
            groups: ["A"]
            anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            color:"#FF1010"
            redVariation: 0.8  // 红色系
        }
        Emitter {
            group: "A"
            emitRate: 100
            lifeSpan: 2800
            size: 32
            sizeVariation: 8
            velocity: PointDirection{ x: 66; xVariation: 20 }  // 44-86的区间发射粒子，朝x正轴方向
            width: 80
            height: 80
        }
        Affector {
            groups: ["A"]
            x: 120
            width: 80
            height: 80
            once: true
            position: PointDirection { x: 120; }  // x=120的位置上放置了一个80*80的affector（啥也没干？）
        }

        //---------------------------------------------
        // 效果B
        //---------------------------------------------
        ImageParticle {
            groups: ["B"]
            anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            color:"#10FF10"
            greenVariation: 0.8 // 绿色系
        }
        Emitter {
            group: "B"
            emitRate: 100
            lifeSpan: 2800
            size: 32
            sizeVariation: 8
            velocity: PointDirection{ x: 240; xVariation: 60 } // 180-300的区间发射粒子，朝x正轴方向
            y: 260
            width: 10
            height: 10
        }
        Affector {
            groups: ["B"]
            x: 120
            y: 240
            width: 80
            height: 80
            once: true
            velocity: AngleDirection { angleVariation:360; magnitude: 72 } // x=120位置有个affector，会改变粒子的角度（发散）
        }


        //---------------------------------------------
        // 效果C
        //---------------------------------------------
        ImageParticle {
            groups: ["C"]
            anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            color:"#1010FF"
            blueVariation: 0.8  // 蓝色系
        }
        Emitter {
            group: "C"
            y: 400
            emitRate: 100
            lifeSpan: 2800
            size: 32
            sizeVariation: 8
            velocity: PointDirection{ x: 80; xVariation: 10 }  // 70-90的区间发射粒子，朝x正轴方向
            acceleration: PointDirection { y: 10; x: 20; }     // 加速器
            width: 80
            height: 80
        }
        Affector {
            groups: ["C"]
            x: 120
            y: 400
            width: 80
            height: 120
            once: true
            relative: false
            acceleration: PointDirection { y: -80; }          // x=120位置有个affector，会改变粒子的方向（向上）
        }

    }
}
