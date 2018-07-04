import QtQuick 2.0
import "common.js" as Common
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2

/**
list<object> 操作示例
    list容纳的是QML对象，不能容纳基础数据类型
    list一旦创建，无法增加删除，只能重新指定一个新的list
*/
Column{
    width: 800
    height: 600
    spacing: 10
    Text {
        width: 200
        height: 100
        text: 'list 类型调用测试，请查看log'
    }

    // list<GradientStop> stops
    property Gradient g : Gradient{
        GradientStop { position: 0.2; color: "green" }
        GradientStop { position: 0.6; color: "yellow" }
        GradientStop { position: 0.8; color: "red" }
    }

    // 线性渐变
    LinearGradient {
        width: 100; height: 100
        start: Qt.point(0, 0)
        end: Qt.point(100, 100) //// BUG：无效5.4
        gradient: g;
    }

    // 按钮区
    Row{
        spacing: 10
        Button{text: 'add';    onClicked: addStop(Math.random(1), 'white');}
        Button{text: 'modify'; onClicked: modStop(0, Math.random(1), 'red')}
        Button{text: 'del';    onClicked: delStop(0);}
        Button{text: 'clear';  onClicked: clearStops();}
        Button{text: 'reset';  onClicked: resetStops();}
    }

    // 动态生成GradientStop的父容器
    Item{id: stopContainer}

    //-----------------------------------------
    // list操作
    //-----------------------------------------
    // 清除所有锚点
    function clearStops(){
        clearChildren(stopContainer);
        var txt = 'import QtQuick 2.0; Gradient {}';
        var o = Qt.createQmlObject(txt, stopContainer, 'qml');
        g.destroy();
        g = o;
    }

    // 设置锚点控件位置
    function resetStops(){
        var stops = g.stops;
        for (var i=0; i<stops.length; i++){
            var stop = stops[i];
            stop.position = 0.1 * i;
            stop.color = Qt.rgba(Math.random(1), Math.random(1), Math.random(1), 1);
        }
    }

    // 修改渐变锚点
    function modStop(n, position, color){
        if (position != null) g.stops[n].position = position;
        if (color != null)    g.stops[n].color = color;
    }


    // 删除渐变锚点(list对象只能重建，无法删除新增）
    function delStop(n){
        var stops = g.stops;
        clearChildren(stopContainer);
        var txt = 'import QtQuick 2.0; Gradient {';
        for (var i=0; i<stops.length; i++){
            if (i == n) continue;
            var stop = stops[i];
            txt += 'GradientStop { position: ' + stop.position + '; color: "' + stop.color + '"}';
        }
        txt += '}';
        var o = Qt.createQmlObject(txt, stopContainer, 'qml');
        g.destroy();
        g = o;
    }

    // 增加渐变锚点(list对象只能重建，无法删除新增）
    function addStop(position, color){
        var stops = g.stops;
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
        g.destroy();
        g = o;
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

