import QtQuick 2.0
import QtGraphicalEffects 1.0

/**
具有毛玻璃效果的视图
    属性target：目标控件。要求与本控件位于同一坐标系
    若本视图遮盖住目标控件，遮盖部分显示毛玻璃效果

思路
    放置一个Blur控件
    计算本视图与目标视图的重叠部分
    移动Blur控件到合适的位置
    依据同样思路，可作出各种不同效果

Lisence: MIT
Author: surfsky.cnblogs.com 2015-01
请保留此声明
*/
Rectangle{
    id: panelFg
    color: 'lightblue'
    width: 200
    height: 200
    clip: true

    // 属性
    property Item target : panelBg  // 模糊源
    property bool dragable : true   // 是否可拖动

    // 毛玻璃效果
    FastBlur {
        id: blur
        source: parent.target
        width: source.width;
        height: source.height
        radius: 64
    }

    // 可拖移
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: dragable ? parent : null
    }

    // 设置模糊组件的位置
    onXChanged: setBlurPosition();
    onYChanged: setBlurPosition();
    Component.onCompleted: setBlurPosition();
    function setBlurPosition(){
        blur.x = target.x - x;
        blur.y = target.y - y;
    }
}

