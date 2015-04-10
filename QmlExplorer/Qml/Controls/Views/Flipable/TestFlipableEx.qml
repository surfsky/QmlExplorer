import QtQuick 2.0
import "../"

/**
测试重封装版的FlipableEx
*/
Rectangle {
    width: 400
    height: 400

    FlipableEx{
        width: 100
        height: 100
        front: Rectangle {color:"red"; width: 100; height:100; radius: 10}
        back:  Rectangle {color:"green"; width:100; height:100; radius: 10}
    }
}
