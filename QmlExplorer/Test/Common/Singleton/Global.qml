/**
单例模式（类似全局类，在qmldir中声明创建，可全局使用）
定义
    pragma Singleton

注册qmldir
    singleton Global Global.qml

使用：
    import "."
    var c = Global.textColor;
*/
pragma Singleton
import QtQuick 2.0


QtObject {
    property color bgColor: 'lightblue';

    property int textSize: 20
    property color textColor: "green"
}
