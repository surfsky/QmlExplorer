import QtQuick 2.0
import QtQuick.Controls 1.1


/**
测试loader组件
    用于动态加载 qml 代码（qml文件或Component），转化为QtObject对象并展示
    也常用于动态切换界面
    很多动态的组件内部都是用loader来实现的，如stackview、tree
    对应Qt.createComponent(), Qt.createQmlObject() 这两个方法
相关方法
    访问加载的对象：loader.item
    销毁加载的对象：loader.item.destory();
    对象的事件处理：Connections
*/
Column {
    id: root
    width: 640
    height: 480
    spacing: 10


    //------------------------------------------
    // 直接指定url
    //------------------------------------------
    // 同步模式，status: 1
    Loader {
        id: loader1
        source: "../../controls/Circle.qml"
        onStatusChanged: {console.log("loader1:" + status);}
    }
    // 异步加载，status: 2>1
    Loader {
        id: loader2
        source: "../../controls/Circle2.qml"
        asynchronous: true
        onStatusChanged: {console.log("loader2:" + status);}
    }

    //------------------------------------------
    // loader2: 直接加载Item报错
    //------------------------------------------
    Rectangle {
        id: blueSquare
        color: "blue"
        width: 50
        height: 50
        visible: false;
    }
    Loader{
        id: loader3
        sourceComponent : blueSquare  // Unable to assign QQuickRectangle_QML_36 to QQmlComponent
        onStatusChanged: {console.log("loader3:" + status);}
    }

    //------------------------------------------
    // loader1: 加载component，修改属性，链接事件
    //------------------------------------------
    Component{
        id: component
        Rectangle {
            id: redSquare
            color: "red"
            width: 50
            height: 50
            signal message(string msg);
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    redSquare.message('click');
                }
                onPressed: parent.color = Qt.darker(parent.color);
                onReleased: parent.color = Qt.lighter(parent.color);
            }
        }
    }
    Loader{
        id: loader4
        sourceComponent : component
        onLoaded: {
            // 修改组件的属性
            //console.log(loader4.item);
            loader4.item.color = 'green';
        }
        Connections {
            target: loader4.item
            onMessage: console.log(msg)
        }
    }





    //------------------------------------------
    // 动态指定
    //------------------------------------------
    Loader {
        id : loader
    }
    Button{
        text: 'create component'
        onClicked: {
            loader.source = "../../controls/Cell.qml";
        }
    }
}
