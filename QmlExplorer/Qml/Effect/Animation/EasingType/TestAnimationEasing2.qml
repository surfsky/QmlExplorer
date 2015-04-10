import QtQuick 2.2
import QtQuick.Controls 1.1


/**
测试动画速度曲线
建议弄个更全面的测试
- 一个待运动的物体
- 一个easying列表
*/
Rectangle {
    id: root
    width: bg.width
    height: bg.height


    //---------------------------------------------
    // items
    //---------------------------------------------
    Image {
        id: bg
        source: "../images/bg.png"
    }

    Image {
        id: rocket
        x: 100
        y: 80
        source: "../images/rocket.PNG"
        rotation: 90
    }


    //---------------------------------------------
    //---------------------------------------------
    Flow{
        x:10; y:10
        height: 300
        spacing: 10
        anchors.left: root.left;
        anchors.right: root.right;

        Button{
            text:'rocket go';
            onClicked: propertyAnimation1.running = true;
        }
        Button{
            text:'rocket go';
            onClicked: propertyAnimation2.running = true;
        }
        Button{
            text:'rocket go';
            onClicked: propertyAnimation3.running = true;
        }
        Button{
            text:'rocket go';
            onClicked: propertyAnimation4.running = true;
        }
        Button{
            text:'rocket go';
            onClicked: propertyAnimation5.running = true;
        }
    }

    //---------------------------------------------
    // 定义动画
    //---------------------------------------------
    NumberAnimation {
        id: propertyAnimation1
        target: rocket
        properties: "x";
        from: 100; to: 800; duration: 600
        easing.type: Easing.InOutQuad
    }
    PropertyAnimation {
        id: propertyAnimation2
        target: rocket
        properties: "x";
        from: 100; to: 800; duration: 600
        easing.type: Easing.InOutBack
    }
    PropertyAnimation {
        id: propertyAnimation3
        target: rocket
        properties: "x";
        from: 100; to: 800; duration: 600
        easing.type: Easing.InExpo
    }
    PropertyAnimation {
        id: propertyAnimation4
        target: rocket
        properties: "x";
        from: 100; to: 800; duration: 600
        easing.type: Easing.InBack
    }
    PropertyAnimation {
        id: propertyAnimation5
        target: rocket
        properties: "x";
        from: 100; to: 800; duration: 600
        easing.type: Easing.OutInBack
    }


}
