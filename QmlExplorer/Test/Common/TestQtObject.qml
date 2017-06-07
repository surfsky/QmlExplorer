import QtQuick 2.0


/**
QtObject
    是 QObject 的qml实现
    是所有qml元素的基类
    它是无UI的组件，适合做结构体、类的基类
    包括唯一属性objectName
tip
    命名为Object更为合适
*/
QtObject {
    // 唯一的属性
    objectName: 'my name'

    // 自定义的属性和方法
    property color colorBg : '#f0f0f0';
    property ListModel fruids : ListModel {
        ListElement {name: "Apple"; cost: 2.45}
        ListElement {name: "Orange"; cost: 3.25}
        ListElement {name: "Banana"; cost: 1.95}
    }

    function hello(){
        console.log('hello world');
    }

}

