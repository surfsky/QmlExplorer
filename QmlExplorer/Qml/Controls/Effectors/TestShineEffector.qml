import QtQuick 2.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0


/**
鼠标悬停会动画发光的按钮
    /呼吸效果
    /用DropShadow做发光效果
    可考虑将效果封装起来，只需要提供接口：source/start()/stop()
*/
Rectangle{
    width: 500
    height: 500
    color: 'black'

    // eg1: 按钮呼吸
    Rectangle{
        id:shineButton
        width: 300
        height: 100
        radius: 10
        color: 'lightblue'
        opacity: 0.8
        anchors.centerIn: parent
        clip: false

        Text{anchors.centerIn: parent; color:'transparent'; text:'Press and hold'; font.pixelSize: 30}
        MouseArea{
            anchors.fill: parent
            onPressed: effector.start();
            onReleased: effector.stop();
        }
    }
    ShineEffector{
        id: effector
        shineSource: shineButton
        shineRadius: 36
        shineColor: 'yellow'
    }


    // eg2
    Image {
        id: butterfly
        width: 200
        height: 200
        source: "./images/butterfly.png"
        smooth: true
    }
    ShineEffector{
        shineSource: butterfly
        shineRadius: 40
        shineColor: 'yellow'
        Component.onCompleted: start();
    }
}

