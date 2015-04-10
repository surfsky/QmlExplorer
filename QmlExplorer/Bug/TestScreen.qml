import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.1


/**
Q: Screen 对象在Component.onCompleted并没有初始化(qt 5.4)
A： Note that the Screen type is not valid at Component.onCompleted, because the Item or Window has not been displayed on a screen by this time.
T: 这个错误会很隐晦的
*/
Grid{
    x:10
    y:10
    spacing: 10
    columns: 2
    width: 300
    height: 200

    property double dpi: Screen.pixelDensity * 25.4;

    // 为什么log和text的结果不一样？(qt 5.4)
    Text{text: "Screen.pixelDensity"}
    Text{text: Screen.pixelDensity}
    Text{text: "dpi"}
    Text{text: dpi}


    // Screen 对象在Component.onCompleted并没有初始化(qt 5.4)
    // Screen 啥时候初始化完毕？
    Component.onCompleted: {
        console.log(Screen.pixelDensity)
        console.log(dpi);
    }

    // 可正常输出
    Screen.onPixelDensityChanged: {
        console.log(Screen.pixelDensity)
    }
}
