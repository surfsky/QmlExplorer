import QtQuick 2.2
import QtQuick.Controls 1.1


/**
多个信号（signal），一个处理器（connections）
（1）首先，一个处理器同时处理多个信号发生器的信号，现阶段QML是实现不了的（qt 5.4）
    - connections的作用是搭个桥，一头是一个信号发生器，一头是信号逻辑
    - 信号发生器必须显式指定，且只能是一个
（2）可以用动态切换信号源的办法，交替使用信号处理器
    - 多个信号发生源必须有相同的信号定义
    - 可动态指定 connections.target
    - 可指定 connections.target = loader.item，动态切换loader源
*/
Column {
    width: 600
    height: 400
    spacing: 20


    //------------------------------------------
    // 方法1：动态切换loader的source
    //------------------------------------------
    Row{
        spacing: 5
        Button{text: 'change sender 1'; onClicked: loader.sourceComponent=sender1;}
        Button{text: 'change sender 2'; onClicked: loader.sourceComponent=sender2;}
        Button{text: 'change sender 3'; onClicked: loader.sourceComponent=sender3;}
    }
    Loader{
        id: loader
        sourceComponent: sender1;
        onLoaded: console.log(sourceComponent);
    }
    Component{id: sender1; TestSignal{}}
    Component{id: sender2; TestSignal{}}
    Component{id: sender3; TestSignal{}}
    Connections {
        //target: [signal1, signal2, signal3]   // fail
        target: loader.item
        onMessage1: console.log('message1');
        onMessage2: console.log('message2');
    }



    //------------------------------------------
    // 方法2：动态切换connection的target
    //------------------------------------------
    Row{
        spacing: 5
        Button{text: 'active sender 1'; onClicked: c1.target=s1;}
        Button{text: 'active sender 2'; onClicked: c1.target=s2;}
        Button{text: 'active sender 3'; onClicked: c1.target=s3;}
    }
    Row{
        spacing: 5
        TestSignal{id: s1}
        TestSignal{id: s2}
        TestSignal{id: s3}
    }
    Connections {
        id: c1
        onMessage1: console.log('message1');
        onMessage2: console.log('message2');
    }
    // 这两行代码会导致qmlscene崩溃（qt5.4）
    //property alias s1 : s1;
    //s1.onMessage1: console.log('s1');
}

