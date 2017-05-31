import QtQuick 2.0

/**
显示FPS值
    （1）Qml的Animation刷新频率是受FPS制约的
    （2）那么我们定义一个无限循环的animation，针对某个属性，属性值我们并不关心，我们只记录它的更新次数
    （3）每分钟取一次更新次数，就是我们要的FPS值了

Lisence: MIT 请保留此声明
Author: surfsky.cnblogs.com, 2015-02-11
*/
Text {
    id: root
    width: 100
    height: 62

    property int count: 0     // 刷新计数器
    property int dummy: 0     // 随便定义一个属性，让动画去更新它
    onDummyChanged: count++;  // 每次更新属性都记录一次计数器

    // 定义一个无限循环的animation（触发频率要大于FPS）
    NumberAnimation on dummy {
        duration: 500
        from: 0
        to: 10000
        loops: Animation.Infinite
    }

    // 每分钟显示一下计数器值（就是FPS）
    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            root.text = count;
            count = 0;
        }
    }

}
