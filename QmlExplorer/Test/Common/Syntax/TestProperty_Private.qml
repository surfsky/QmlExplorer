import QtQuick 2.0

/**
Qml没有private关键字
可用局部变量的方式来模拟实现, 仅内部可用，不公布到外部
此外Qt官方也用两个下划线的方式来定义私有属性，只是约定，编译器并不限制调用者访问
*/
Column {
    width: 800
    height: 600

    //
    Dummy{
        id: dummy
        publicProperty: 20
        __privateProperty: 10
        //p.privateProperty: 10   // fail
    }
}

