import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.1


/**
弹出层控件
功能
    /禁止事件穿透，不让下层事件触发
    /灯箱效果
    /动画效果
    /可拖拽
    仿mac的最小化变形动画
    阴影效果
    控制width、height动画的中心点
使用
    Popup {
        id: popup
        width: 200; height: 300
        x: 200; y:100
        //anchors.centerIn: parent  // 注意：使用位移动画不能用anchors定位方式
        z: 101
        opacity: 0.8
        visible: false;
        radius: 5
        dragable: true
        ...
    }
    popup.showMask = chk.checked;
    popup.animationType = 'size';
    //popup.duration = 1000;
    //popup.easingType = Easing.OutElastic;
    popup.show();

注意
    使用位移动画不能用anchors定位方式
BUG
    嵌入到applicationWindow中，并启用mask，弹出框按钮无法响应

Lisence: MIT
History:
    create. SURFSKY.CNBLOGS.COM, 2014-09
    add dragable property. surfsky, 2015-01
请保留此声明
*/
Rectangle {
    id: root
    width: 100
    height: 200
    color: 'lightblue'
    z:100
    transformOrigin: Item.Center  // 无效

    // 公有属性
    property bool showMask : false;
    property string animationType : 'none';
    property int duration : 500
    property int easingType : Easing.OutBounce
    property bool dragable : true


    // 私有属性
    property int innerX;
    property int innerY;
    property int innerWidth;
    property int innerHeight;
    property double innerOpacity;


    //------------------------------
    // 事件
    //------------------------------
    // 属性备份一下，避免动画对属性进行变更
    Component.onCompleted: {
        save();
    }

    function show()
    {
        reset();
        switch (animationType)
        {
            case "fade":     animFadeIn.start(); break;
            case "focus":    animFocusIn.start(); break;
            case "width":    animWidthIncrease.start(); break;
            case "height":   animHeightIncrease.start(); break;
            case "size":     animBig.start(); break;
            case "flyDown":  animInDown.start(); break;
            case "flyUp":    animInUp.start(); break;
            case "flyLeft":  animInLeft.start(); break;
            case "flyRight": animInRight.start(); break;
            default:         this.visible = true;
        }
    }

    function hide()
    {
        switch (animationType)
        {
            case "fade":    connector.target = animFadeOut;        animFadeOut.start(); break;
            case "focus":   connector.target = animFocusOut;       animFocusOut.start(); break;
            case "width":   connector.target = animWidthDecrease;  animWidthDecrease.start();   break;
            case "height":  connector.target = animHeightDecrease; animHeightDecrease.start();  break;
            case "size":    connector.target = animSmall;          animSmall.start();   break;
            case "flyDown": connector.target = animOutUp;          animOutUp.start();   break;
            case "flyUp":   connector.target = animOutDown;        animOutDown.start(); break;
            case "flyLeft": connector.target = animOutRight;       animOutRight.start();break;
            case "flyRight":connector.target = animOutLeft;        animOutLeft.start(); break;
            default:        close();
        }
    }

    // 动画结束后调用的脚本
    Connections{
        id: connector
        target: animInDown
        onStopped: close()
    }



    //------------------------------
    // 辅助方法
    //------------------------------
    function getRoot(item)
    {
        return (item.parent !== null) ? getRoot(item.parent) : item;
    }

    function save()
    {
        innerX = root.x;
        innerY = root.y;
        innerWidth = root.width;
        innerHeight = root.height;
        innerOpacity = root.opacity;
        console.log("x=" + innerX + " y="+innerY + " w=" + innerWidth + " h="+innerHeight);
    }

    function reset()
    {
        root.x = innerX;
        root.y = innerY;
        root.width = innerWidth
        root.height = innerHeight;
        root.opacity = innerOpacity;
        root.scale = 1;

        connector.target = null;
        mask.visible = showMask;
        root.visible = true;
    }

    // 立即关闭
    function close()
    {
        mask.visible = false;
        root.visible = false;
        log();
    }

    function log()
    {
        console.log("x=" + x + " y="+y + " w=" + width + " h="+height);
    }




    //------------------------------
    // 遮罩
    //------------------------------
    // 禁止事件穿透
    MouseArea{
        anchors.fill: parent;
        onPressed:{mouse.accepted = true}  // 禁止事件穿透
        drag.target: dragable ? root : null  // root可拖动
    }


    // 灯箱遮罩层
    Mask{
        id: mask
        visible: false
    }





    //------------------------------
    // 动画
    //------------------------------
    // fadeIn/fadeOut
    PropertyAnimation {
        id:animFadeIn
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'opacity';
        from: 0;
        to: root.innerOpacity
    }
    PropertyAnimation {
        id: animFadeOut
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'opacity';
        from: root.innerOpacity;
        to: 0
    }

    // width
    PropertyAnimation {
        id: animWidthIncrease
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'width';
        from: 0;
        to: root.innerWidth
    }
    PropertyAnimation {
        id: animWidthDecrease
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'width';
        from: root.innerWidth;
        to: 0
    }

    // height
    PropertyAnimation {
        id: animHeightIncrease
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'height';
        from: 0;
        to: root.innerHeight
    }
    PropertyAnimation {
        id: animHeightDecrease
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'height';
        from: root.innerHeight;
        to: 0
    }


    // size（如何控制size动画的中心点）
    PropertyAnimation {
        id: animBig
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'scale';
        from: 0;
        to: 1
    }
    PropertyAnimation {
        id: animSmall
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'scale';
        from: 1;
        to: 0
    }

    // focus
    ParallelAnimation{
        id: animFocusIn
        PropertyAnimation {
            target: root
            duration: root.duration
            easing.type: Easing.Linear
            property: 'scale';
            from: 10;
            to: 1
        }
        PropertyAnimation {
            target: root
            duration: root.duration
            easing.type: Easing.Linear
            property: 'opacity';
            from: 0;
            to: root.innerOpacity
        }
    }
    ParallelAnimation{
        id: animFocusOut
        PropertyAnimation {
            target: root
            duration: root.duration
            easing.type: Easing.Linear
            property: 'scale';
            from: 1;
            to: 10
        }
        PropertyAnimation {
            target: root
            duration: root.duration
            easing.type: Easing.Linear
            property: 'opacity';
            from: root.innerOpacity;
            to: 0
        }
    }



    // fly in
    PropertyAnimation {
        id: animInRight
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'x';
        from: -root.innerWidth;
        to: root.innerX
    }
    PropertyAnimation {
        id: animInLeft
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'x';
        from: getRoot(root).width;
        to: root.innerX
    }
    PropertyAnimation {
        id: animInUp
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'y';
        from: getRoot(root).height;
        to: root.innerY
    }
    PropertyAnimation {
        id: animInDown
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'y';
        from: -root.innerHeight
        to: root.innerY
    }


    // fly out
    PropertyAnimation {
        id: animOutRight
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'x';
        from: root.innerX;
        to: getRoot(root).width
    }
    PropertyAnimation {
        id: animOutLeft
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'x';
        from: root.innerX;
        to: -root.width
    }
    PropertyAnimation {
        id: animOutUp
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'y';
        from: root.innerY;
        to: -root.height
    }
    PropertyAnimation {
        id: animOutDown
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'y';
        from: root.innerY
        to: getRoot(root).height
    }
}
