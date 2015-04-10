import QtQuick 2.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0


/**
呼吸发光效果（用DropShadow和Animation实现）
接口：
    shineSource
    shineRadius
    start()
    stop()
*/
// 阴影（外发光）
DropShadow {
    id: effector

    // 公共接口
    property Item shineSource;
    property int shineRadius: 50
    property alias shineColor: effector.color
    function start(){
        animBreath.start();
    }
    function stop(){
        animBreath.stop();
    }

    //
    width: wrapper.width
    height: wrapper.height
    anchors.centerIn: shineSource
    radius: 0
    samples: 32
    color: "white"
    source:  Rectangle{
        id: wrapper
        width: src.width + shineRadius
        height: src.height + shineRadius
        color: 'transparent'
        DropShadow {
            id: src
            anchors.centerIn: parent
            width: shineSource.width
            height: shineSource.height
            radius: 0
            samples: 0
            source: shineSource
        }
    }

    // 动画效果（呼吸）
    SequentialAnimation{
        id: animBreath
        loops: -1
        alwaysRunToEnd: true
        PropertyAnimation{target: effector; property: 'radius'; from: 0; to: shineRadius; duration: 1000}
        PropertyAnimation{target: effector; property: 'radius'; from: shineRadius; to: 0; duration: 1000}

        //onStarted: effector.samples = 35;
        //onStopped: effector.samples = 0;
    }
}

