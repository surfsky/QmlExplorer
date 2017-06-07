import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Particles 2.0

/**
场景切换粒子效果测试。参考
http://blog.csdn.net/gamesdev/article/details/34840415
可用该思路模拟实现部落冲突里面的云朵场景切换
*/
ApplicationWindow
{
    visible: true
    width: 640
    height: 480
    title: qsTr( "测试场景切换" )

    // 场景切换
    function sceneTransition( thisScene, nextScene )
    {
        emitterTimer.thisScene = thisScene;
        emitterTimer.nextScene = nextScene;
        emitter.enabled = true;
    }

    // 两个场景，点击后播放过场动画
    Rectangle
    {
        id: scene_1
        visible: true
        anchors.fill: parent
        Text
        {
            anchors.centerIn: parent
            textFormat: Text.RichText
            text: qsTr( "<h1><font color=red>这是第一个场景</color></h1>" )
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked: sceneTransition( scene_1, scene_2 )
        }
    }
    Rectangle
    {
        color: 'lightgreen'
        id: scene_2
        visible: false
        anchors.fill: parent
        Text
        {
            anchors.centerIn: parent
            textFormat: Text.RichText
            text: qsTr( "<h1><font color=green>这是第二个场景</color></h1>" )
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked: sceneTransition( scene_2, scene_1 )
        }
    }

    // 粒子效果
    ParticleSystem
    {
        anchors.centerIn: parent
        ImageParticle
        {
            source: "qrc:///particleresources/star.png"
            colorVariation: 0.75
        }
        Emitter
        {
            id: emitter
            enabled: false
            emitRate: 2000
            size: 32
            lifeSpan: 4000
            velocity: AngleDirection
            {
                magnitude: 200
                angleVariation: 360
            }
        }
    }

    // 定时器
    Timer
    {
        id: emitterTimer
        running: emitter.enabled
        interval: 2000
        property var nextScene
        property var thisScene
        onTriggered:
        {
            thisScene.visible = false;
            nextScene.visible = true;
            emitter.enabled = false;
        }
    }
}
