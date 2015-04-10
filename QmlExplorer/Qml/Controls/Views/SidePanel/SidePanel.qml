import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import "../../../KeyMouseTouch/SwipeMouseArea"

/**
左右菜单栏示例
- 右拉，显示左侧菜单栏，主窗体变小；反之逆过程；
- 左拉，显示右侧菜单栏，主窗体变小；反之逆过程；
- 可给主窗体加上阴影
- 可控主窗体是否放缩

建议改进
- 美化
- 引入state
- 再封装，提供属性: leftPanel, mainPanel, rightPanel

作者
- surfsky.cnblogs.com
- 2014-11

*/
Rectangle {
    id: root
    width: 600
    height: 800
    color: '#f0f0f0'

    // 是否开启主窗体放缩动画
    property bool enableScale : true;
    property bool enableShadow : true;


    // 左面板
    Rectangle{
        id: panelLeft
        x: 0; y:0
        width: 400
        height: parent.height
        color: Qt.darker('lightgreen')
        Text{text: 'left panel'; anchors.centerIn: parent}  // 可用Loader
    }

    // 右面板
    Rectangle{
        id: panelRight
        x: parent.width-width; y:0
        width: 400
        height: parent.height
        color:  Qt.darker('lightblue')
        Text{text: 'right panel'; anchors.centerIn: parent} // 可用Loader
    }

    // 主面板
    Rectangle{
        id: panelMain
        x: 0; y:0
        z:99
        width: parent.width
        height: parent.height
        color: 'pink'

        // 最后位置(X)
        property int lastX : 0;

        // 标题工具栏
        Rectangle{
            id: barTitle
            width: parent.width
            height: 60
            x:0; y:0
            color: '#e0e0e0'
            Text{text: 'main'; anchors.centerIn: parent}
            // 左按钮
            Rectangle{
                id: btnLeft
                width:60;
                height:parent.height
                x:0; y:0
                color: 'lightgreen'
                Image{
                    source: 'menu.png'
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if (panelMain.x > 0) animCenter.start();
                        else                 animSwipeRight.start();
                    }
                }
            }
            // 右按钮
            Rectangle{
                id: btnRight
                width:60
                height:parent.height
                x: parent.width - width
                y: 0
                color: 'lightblue'
                Image{
                    source: 'people.png'
                    anchors.centerIn: parent
                    scale: 0.8
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if (panelMain.x < 0) animCenter.start();
                        else                 animSwipeLeft.start();
                    }
                }
            }
        }

        // 内容区
        Loader{
            width: parent.width;
            height: parent.height - barTitle.height
            x:0
            y:barTitle.height
        }
    }

    // 右下角阴影（必须嵌套一层外框，再使用阴影，否则阴影会给切割掉）
    DropShadow {
        id: shadow
        anchors.centerIn: panelMain
        width: source.width;
        height: source.height
        radius: 8
        samples: 16
        spread: 0.0
        horizontalOffset: 5
        verticalOffset: 5
        color: "#80000000"
        z: 1
        visible: root.enableShadow
        source: Rectangle{
            width: clone.width + 40
            height: clone.height + 40
            color: 'transparent'
            DropShadow {
                id: clone
                anchors.centerIn: parent
                width: source.width
                height: source.height
                scale: source.scale
                radius: 0
                samples: 0
                source: panelMain
            }
        }
    }




    //----------------------------------------------
    // 左右滑屏显示左右菜单
    //----------------------------------------------
    SwipeMouseArea {
        id: mouseArea
        anchors.fill: parent;

        // 用手swipe移动主面板
        onSwipe: {
            console.log('swipe: ' + swipeData.direction + ", " + swipeData.dx + ", " + swipeData.dy);
            console.log('main.x = ' + panelMain.x);

            // 显隐左右面板
            if (panelMain.x < 0) {panelRight.opacity = 1;  panelLeft.opacity = 0;}  // 计算左右面板的透明度、主面板的放缩大小（未完成）
            else                 {panelRight.opacity = 0; panelLeft.opacity = 1;}

            // 左滑右滑带动主面板变动
            if (swipeData.dx < 0)
            {
                // 限制拖动的距离
                if (-panelMain.x >= panelRight.width){
                    panelMain.x = -panelRight.width;
                    return;
                }
                panelMain.x = panelMain.lastX + swipeData.dx;
            }
            if (swipeData.dx > 0)
            {
                // 限制拖动的距离
                if (panelMain.x >= panelLeft.width){
                    panelMain.x = panelLeft.width;
                    return;
                }
                panelMain.x = panelMain.lastX + swipeData.dx;
            }
        }

        // 用动画移动主面板
        onReleased: {
            panelMain.lastX = panelMain.x;
            if (swipeData.direction != 'None'){
                console.log('swipe: ' + swipeData.direction + ", " + swipeData.dx + ", " + swipeData.dy);
                if (panelMain.x < 0) {
                    if (swipeData.direction.indexOf("Left") !== -1)  animSwipeLeft.running = true;
                    else                                             animCenter.running = true;
                }
                else {
                    if (swipeData.direction.indexOf("Right") !== -1) animSwipeRight.running = true;
                    else                                             animCenter.running = true;
                }
            }
        }
    }

    //----------------------------------------------
    // 位移动画
    //----------------------------------------------
    // 居中显示主面板
    ParallelAnimation{
        id: animCenter
        NumberAnimation{target: panelMain; properties: 'x'; from: panelMain.lastX; to: 0; easing.type: Easing.OutExpo}
        NumberAnimation{target: enableScale?panelMain:null; properties: 'scale'; from: 0.9; to: 1;easing.type: Easing.OutExpo;}
        NumberAnimation{target: panelLeft; properties: 'opacity'; from: 1;               to: 0;             easing.type: Easing.OutExpo}
        NumberAnimation{target: panelRight; properties: 'opacity'; from: 1;               to: 0;             easing.type: Easing.OutExpo}
        ScriptAction{
            script :{
                panelMain.lastX = 0;
                console.log(panelMain.lastX);
            }
        }
    }

    // 显示左菜单面板
    SequentialAnimation{
        id: animSwipeRight
        ParallelAnimation{
            NumberAnimation{target: panelMain; properties: 'x';     from: panelMain.lastX; to: panelLeft.width; easing.type: Easing.OutExpo}
            NumberAnimation{target: enableScale?panelMain:null; properties: 'scale'; from: 1;               to: 0.9;             easing.type: Easing.OutExpo}
            NumberAnimation{target: panelLeft; properties: 'opacity'; from: panelLeft.opacity;   to: 1;             easing.type: Easing.OutExpo}
            NumberAnimation{target: panelRight; properties: 'opacity'; from: 1;               to: 0;             easing.type: Easing.OutExpo}
        }
        ScriptAction{
            script :{
                panelMain.lastX = panelMain.x;
//                shadow.width = panelMain.width;
//                shadow.height = panelMain.height;
//                shadow.scale = panelMain.scale;
//                shadow.update();
                console.log(panelMain.lastX);
            }
        }
    }

    // 显示右菜单面板
    SequentialAnimation{
        id: animSwipeLeft
        ParallelAnimation{
            NumberAnimation{target: panelMain; properties: 'x';     from: panelMain.lastX; to: -panelRight.width; easing.type: Easing.OutExpo}
            NumberAnimation{target: enableScale?panelMain:null; properties: 'scale'; from: 1;               to: 0.9;               easing.type: Easing.OutExpo}
            NumberAnimation{target: panelLeft; properties: 'opacity'; from: 1;               to: 0;             easing.type: Easing.OutExpo}
            NumberAnimation{target: panelRight; properties: 'opacity'; from: panelRight.opacity;         to: 1;             easing.type: Easing.OutExpo}
        }
        ScriptAction{
            script :{
                panelMain.lastX = panelMain.x;
//                shadow.width = panelMain.width;
//                shadow.height = panelMain.height;
//                shadow.scale = panelMain.scale;
//                shadow.update();
                console.log(panelMain.lastX);
            }
        }
    }

}
