import QtQuick 2.0
import "../../js/qml.js" as Common

/**
测试 Item 作为所有可视元素的基类
*/
Column {
    width: 600
    height: 400

    Text{
        text:'
Item 作为所有可视元素的基类
  继承自 QtObject
  具有以下相关属性
    物理属性
        尺寸：x,y,z,width,height,baselineOffset, childrenRect
        内在尺寸：implicitWidth, implicitHeight（适合图片和文本）
        透明: opacity
        变形：scale, rotation, transform
        对齐：anchors
    状态: state, states, transitions
    层效果：layer
    展示效果：smooth, antialiasing
    其他: enabled, focus, clip, visible
    子元素
        data: 可视以及不可视子元素的集合。default属性
        children： 可视子元素集合
        resources： 不可视子元素集合
        visibleChildren：可视子元素（且可见）集合（只读）

注：
    Item是背景透明的，而Rectangle默认背景色为白色
    请查看console 输出（遍历子元素）
        '
    }


    // 传统写法
    Item {
        id: item1
        Text {}
        Rectangle {}
        Timer {}
    }

    // 事实上等效于
    Item {
        id: item2
        children: [
            Text {},
            Rectangle {}
        ]
        resources: [
            Timer {}
        ]
    }

    // 遍历所有元素（未完成）
    Component.onCompleted: {
        Common.printItem(item1);
        Common.printItem(item2);
    }
}
