import QtQuick 2.0
import QtQuick.Window 2.0


/**
HUD 提示文本层，会自动消失
特性
    /最上层显示
    /图文
    /动画
    /定时消失
    出现的位置（居中？最上面？）
可用 popup 改造：
    图片和文本
    定时器
    相关属性
*/
Rectangle {
    id: root
    width: 300
    height: 60
    opacity: 0.8
    color: '#0f0f0f'
    z:99
    radius: 5


    // 公共属性
    property alias duration: timer.interval
    property alias text: txt.text
    property alias imageUrl: img.source

    // 居屏幕中间放置（可考虑用ParentChange来实现）
    anchors.centerIn: getRoot(this)

    // 倒推查找根元素
    function getRoot(item)
    {
        return (item.parent !== null) ? getRoot(item.parent) : item;
    }

    //---------------------------------------
    // 初始化
    //---------------------------------------
    function init(){
        root.scale = 1.0
        root.opacity = 0.8
        root.visible = true;
        root.parent = getRoot(root);
    }

    function show(text){
        if (text != null)
            root.text = text;
        init();
        timer.start();
    }

    //---------------------------------------
    // UI
    //---------------------------------------
    // 图像和文本元素
    Row{
        anchors.fill: parent
        anchors.leftMargin: 10
        spacing: 10
        Image{
            id: img
            //source: 'http://qt-project.org/images/qt13a/Qt-logo.png'
            //scale: 0.5
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            id: txt
            color: 'white'
            text: 'hello world'
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // 禁止事件穿透，不让别的控件受理本popup上的事件
    MouseArea{
        anchors.fill: parent;
        onPressed:{
             mouse.accepted = true
        }
    }


    //---------------------------------------
    // 定时隐藏
    //---------------------------------------
    Timer{
        id: timer
        interval: 2000
        repeat: false
        onTriggered: animDisapear.start();
    }
    ParallelAnimation{
        id: animDisapear
        PropertyAnimation{
            target: root
            properties: 'scale'
            from: 1.0
            to: 1.5
            easing.type: Easing.OutExpo
            duration: 500
        }
        PropertyAnimation{
            target: root
            properties: 'opacity'
            from: 1.0
            to: 0.0
            easing.type: Easing.OutExpo
            duration: 500
        }
        onStopped: {
            root.visible = false;
        }
    }




}
