import QtQuick 2.0


/**
公私有属性测试
*/
Rectangle {
    width: 100
    height: 100
    color: 'lightblue'
    radius: 5

    // 公共属性
    property int publicProperty : 10;

    // qml的私有属性Qt官方一般都加上两个下划线
    // 仍然会被外部调用，编译器并没有约束，只是约定
    property int __privateProperty : 10;


    // 此外，私有属性也可以封装到QtObject里面去，仅本文件内使用
    QtObject{
        id: p
        property int privateProperty : 20;
    }

    //
    Component.onCompleted: {
        console.log(publicProperty);
        console.log(__privateProperty);
        console.log(p.privateProperty);
    }
}

