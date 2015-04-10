import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2


/*!
\brief 渐变色彩设置控件
模拟并简化ps渐变设置工具
    /渐变轴上有若干色块锚点
    /锚点点击弹出色彩选择控件供设置色彩
    /设置完毕，渐变轴刷新
    /锚点可拖移，拖移中渐变轴实时刷新
    /点击渐变轴空白处，新增锚点
    /将锚点拖到界面外可删除

改进
    自定义取色器

协议：MIT. 请保留本协议说明
历史：初版 2015-01-09 surfsky.cnblogs.com
*/
Rectangle{
    id: root
    width: 400
    height: 30

    //-----------------------------------------------------
    // 属性
    //-----------------------------------------------------
    property Gradient gradient : Gradient{
        GradientStop { position: 0.2; color: "green" }
        GradientStop { position: 0.6; color: "yellow" }
        GradientStop { position: 0.8; color: "red" }
    }
    property Item _currentStoper;  // 当前选择的渐变节点
    property int stoperWidth: 20;


    //-----------------------------------------------------
    // 事件
    //-----------------------------------------------------
    onWidthChanged: setStopers();
    Component.onCompleted: {showStopers(); bg.requestPaint();}

    //-----------------------------------------------------
    // 渐变底色
    //-----------------------------------------------------
    // 渐变背景
    Canvas{
        id: bg
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            var grdt = ctx.createLinearGradient(0, 0, root.width, 0);
            for (var i=0; i<gradient.stops.length; i++)
            {
                var stop = gradient.stops[i];
                grdt.addColorStop(stop.position, stop.color);
            }
            ctx.fillStyle = grdt;
            ctx.fillRect(0, 0, width, height);
        }
    }

    // 色彩对话框（在移动平台上会怎么样？考虑用弹出色板来替代）
    ColorDialog {
        id: colorDialog
        property var sender;
        onAccepted: {
            sender.color = colorDialog.currentColor;
            modStop(sender.stopId, null, sender.color);
            bg.requestPaint();
        }
    }

    // 点击背景色带增加一个锚点fs
    MouseArea{
        anchors.fill: parent
        onClicked: {
            addStop(mouseX/width, 'red');
            showStopers();
            bg.requestPaint();
            mouse.accepted = true; // 防止事件穿透
        }
    }



    //-----------------------------------------------------
    // 色彩锚点
    //-----------------------------------------------------
    // 用于容纳动态生成GradientStop
    Item{id: stopContainer}

    // 用于容纳动态生成锚点控件
    Item{
        id: stoperContainer
        width: parent.width
        height: parent.height*2/3
        anchors.verticalCenter: parent.verticalCenter
    }

    // 色彩锚点控件
    Component{
        id: stoper
        Rectangle{
            id: rect1
            property int stopId: 1;
            width: stoperWidth
            height: stoperContainer.height
            radius: width/2
            border.color: 'white'
            border.width: 2
            MouseArea{
                id: mouse
                anchors.fill: parent
                drag.target: parent;
                drag.axis: Drag.XAxis;
                drag.minimumX: -100;
                drag.maximumX: stoperContainer.width+100
                onPressed: parent.border.color = 'black'
                onReleased: parent.border.color = 'white'
                onClicked: {
                    root._currentStoper = parent;
                    colorDialog.sender = parent;
                    colorDialog.color = parent.color;
                    colorDialog.open();
                    mouse.accepted = false;
                }
            }
            onXChanged: {
                if (mouse.pressed){
                    // 拖到边界外删除
                    if (x < -width/2 || x>stoperContainer.width){
                        console.log('delete stop: ' + stopId);
                        delStop(stopId);
                        showStopers();
                    }
                    else
                        modStop(stopId, (x+width/2)/root.width, null);
                    showGradientBg();
                }
            }
        }
    }



    //-----------------------------------------------------
    // 渐变锚点处理
    //-----------------------------------------------------
    // 显示渐变背景
    function showGradientBg(){
        bg.requestPaint();
    }

    // 显示锚点控件
    function showStopers(){
        var stops = gradient.stops;
        clearChildren(stoperContainer);
        for (var i=0; i<stops.length; i++){
            var stop = stops[i];
            var o = stoper.createObject(stoperContainer, {});
            o.stopId = i;
            o.color = stop.color;
            o.x = stoperContainer.width * stop.position - stoperWidth/2;
            console.log('i=' + i + ', position=' + stop.position + ', x=' + o.x);
        }
    }

    // 设置锚点控件位置
    function setStopers(){
        var stops = gradient.stops;
        for (var i=0; i<stops.length; i++){
            var stop = stops[i];
            var o = stoperContainer.children[i];
            o.x = stoperContainer.width * stop.position - stoperWidth/2;
        }
    }

    // 修改渐变锚点
    function modStop(n, position, color){
        if (position != null) gradient.stops[n].position = position;
        if (color != null)    gradient.stops[n].color = color;
    }


    // 删除渐变锚点(list对象只能重建，无法删除新增）
    function delStop(n){
        var stops = gradient.stops;
        clearChildren(stopContainer);
        var txt = 'import QtQuick 2.0; Gradient {';
        for (var i=0; i<stops.length; i++){
            if (i == n) continue;
            var stop = stops[i];
            txt += 'GradientStop { position: ' + stop.position + '; color: "' + stop.color + '"}';
        }
        txt += '}';
        var o = Qt.createQmlObject(txt, stopContainer, 'qml');
        gradient.destroy();
        gradient = o;
    }

    // 增加渐变锚点(list对象只能重建，无法删除新增）
    function addStop(position, color){
        var stops = gradient.stops;
        clearChildren(stopContainer);
        var txt = 'import QtQuick 2.0; Gradient {';
        for (var i=0; i<stops.length; i++){
            var stop = stops[i];
            txt += 'GradientStop { position: ' + stop.position + '; color: "' + stop.color + '"}';
        }
        txt += 'GradientStop { position: ' + position + '; color: "' + color + '"}';
        txt += '}';
        console.log(txt);
        var o = Qt.createQmlObject(txt, stopContainer, 'qml');
        gradient.destroy();
        gradient = o;
    }

    // 删除子节点
    function clearChildren(item){
        var childrens = item.children;
        for (var i = 0; i < children.length; i++){
            try{children[i].destory(0);}
            catch (e){}
        }
        item.children = [];
    }
}

