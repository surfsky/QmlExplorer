import QtQuick 2.2
import QtQuick.Controls 1.1



/**
测试动画（定义一个动画，手工激活它）
疑问：如何控制旋转的中心点？
QtQuick 2.0 Animation
    - 完全重写，不再依赖 QtCore animation framework
    - 优化内存和性能
    - 新的动画元素
        AnimationController
        Sprite
        SpriteSequence
        AnimatedSprite

相关的Animation
    /PropertyAnimation 属性变换动画（以下的8种其实都可以用PropertyAnimation摆平）
        /NumberAnimation
            /SmoothedAnimation 允许属性平滑的过度(easing.type = linear)
            /SpringAnimation 一种加速回弹的效果(easying.type = inout?)
        /ColorAnimation 颜色进行的变换动画
        /RotationAnimation 对旋转进行的变换动画
        ParentAnimation 对父节点进行变换的动画，改变绑定的父节点
        AnchorAnimation 对anchor 进行改变的动画
        Vector3dAnimation 对QVector3d进行的属性
    /SequentialAnimation 对定义的动画串行播放
    /ParallelAnimation 对定义的动画并行播放
    /PauseAnimation 延迟处理

BUG
    RotationAnimation 无法控制旋转方向
    SmoothedAnimation 必须重置目标属性才能重新开启

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
        source: "./images/bg.png"
    }

    Image {
        id: rocket
        x: 200
        y: 80
        source: "./images/rocket.PNG"
        rotation: 90
    }

    Rectangle{
        id: rect2
        color: 'lightblue'
        opacity: 0.7
        width: 200
        height: 200
        x: 200
        y: root.height - height - 200
    }
    Rectangle{
        id: rect1
        color: 'lightblue'
        opacity: 0.7
        width: 200
        height: 200
        x: 400
        y: root.height - height -400
    }

    //---------------------------------------------
    // 按钮区
    //---------------------------------------------
    Flow{
        x:10
        y:10
        height: 300
        spacing: 10
        anchors.left: root.left;
        anchors.right: root.right;
        Button{text:'property';   onClicked: switchAnimation(animProperty)}
        Button{text:'smooth';     onClicked: {rocket.x = 200; switchAnimation(animSmooth);}}  //bug...
        Button{text:'spring';     onClicked: switchAnimation(animSpring)}
        Button{text:'sequential'; onClicked: switchAnimation(animSequential)}
        Button{text:'parallel';   onClicked: switchAnimation(animParallel)}
        Button{text:'number';     onClicked: switchAnimation(animNumber)}
        Button{text:'rotation';   onClicked: switchAnimation(animRotation)}
        Button{text:'parent';     onClicked: switchAnimation(animParent)}
        Button{text:'opacity';    onClicked: switchAnimation(animOpacity)}
        Button{text:'reset';      onClicked: reset();}
    }

    property var animCurrent : animProperty;
    function switchAnimation(anim){
        console.log(anim);
        if (anim == animCurrent)
            animCurrent.running = !animCurrent.running;
        else{
            reset();
            animCurrent = anim;
            animCurrent.running = true;
        }
    }
    function reset(){
        if (animCurrent != null)
            animCurrent.running = false;
        rocket.x = 200;
        rocket.rotation = 90;
        rocket.opacity = 1.0
        rocket.parent = root;
    }

    //---------------------------------------------
    // 单一动画
    //---------------------------------------------
    PropertyAnimation {
        id: animProperty
        target: rocket
        properties: "x";
        from: 200;
        to: 600
        easing.type: Easing.InOutQuad
        alwaysRunToEnd: true    // 总是将动画运行完毕
    }

    NumberAnimation {
        id : animNumber
        target: rocket
        property: 'rotation'
        running: false;
        from: 0; to: 360;
        loops: Animation.Infinite;
        duration: 1200
    }

    SmoothedAnimation {
        id : animSmooth
        target: rocket
        properties: "x";
        from: 200;
        to: 600
        velocity: 200
    }

    SpringAnimation {
        id : animSpring
        target: rocket
        properties: "x";
        from: 200;
        to: 600
        spring: 2;
        damping: 0.2
    }

    //???? 无效
    RotationAnimation{
        id : animRotation
        target: rocket
        //running: false;
        from: rocket.rotation;
        to: rocket.rotation+360;
        loops: Animation.Infinite;
        duration: 600
        direction: RotationAnimation.Counterclockwise
    }

    //---------------------------------------------
    // 容器动画
    //---------------------------------------------
    // 父属性变更
    ParentAnimation {
        id : animParent
        target: rocket
        newParent : rect1
        via : rect2
        NumberAnimation { properties: "x,y"; duration: 1000 }
    }

    // 顺序执行的动画（显隐闪烁）
    SequentialAnimation{
        id: animOpacity
        loops: -1
        PropertyAnimation{
            target: rocket
            properties: "opacity"
            from:0; to:1
            duration: 2000
        }
        PauseAnimation { duration: 500 }
        PropertyAnimation{
            target: rocket
            properties: "opacity"
            from:1; to:0
            duration: 2000
        }
    }

    // 顺序执行的动画
    SequentialAnimation{
        id: animSequential
        PropertyAnimation {
            target: rocket
            properties: "x";
            from: 200; to: 600
            easing.type: Easing.InOutQuad
        }
        RotationAnimation{
            target: rocket
            from: 90; to: 270;
            duration: 600
        }
        PropertyAction{
            target: rocket
            property: 'opacity'
            value: 0.1
        }
        PauseAnimation { duration: 200 }
        PropertyAction{
            target: rocket
            property: 'opacity'
            value: 1.0
        }
        PropertyAnimation {
            target: rocket
            properties: "x";
            from: 600; to: 200
            easing.type: Easing.InOutQuad
        }
        RotationAnimation{
            target: rocket
            from: -90; to: 90;
            duration: 600
        }
    }

    // 并行执行的动画
    ParallelAnimation{
        id: animParallel
        PropertyAnimation {
            target: rocket
            properties: "x";
            from: 200; to: 600
            easing.type: Easing.InOutQuad
            duration: 600
        }
        RotationAnimation{
            target: rocket
            from: 90; to: 270;
            duration: 600
        }
    }



}
