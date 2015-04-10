import QtQuick 2.0
import QtGraphicalEffects 1.0


/**
模拟iphone slide to unlock 的聚光动画文字效果
    /底层放淡文字
    /前景放高亮文字+半透明遮罩
    /动画移动遮罩

Author: surfsky.cnblogs.com 2015-02
Lisence: MIT, 请保留本文档说明
Usage:
    ShineText{
        text: '> 滑动来解锁'
        fontSize: 20
    }
    请在暗色背景区域测试该控件
*/
Item {
    id: root
    width: 100
    height: 62

    // 公共属性
    property string text: 'slide to unlock';
    property int fontSize: 20
    property bool fontBold: false

    // 背景文字（灰色）
    Text{
        text: root.text
        font.pointSize: root.fontSize
        font.bold: root.fontBold
        color: 'gray'
        opacity: 0.5
    }

    // 前景文字（白色）
    Text{
        id: txt
        text: root.text
        font.pointSize: root.fontSize
        font.bold: root.fontBold
        color: 'white'
        visible: false
    }

    // 半透明遮罩
    OpacityMask {
        id: effect
        width: txt.contentWidth;
        height: txt.contentHeight
        source: txt
        maskSource: gradient
    }

    // 用渐变做遮罩层
    RadialGradient {
        id: gradient
        visible: false
        width: txt.contentWidth;
        height: txt.contentHeight
        horizontalRadius: width/2
        verticalRadius: height*4/5
        horizontalOffset: 0
        gradient: Gradient{
            GradientStop{position: 0.2; color:'white'}
            GradientStop{position: 0.8; color:'transparent'}
        }

        // 用动画移动遮罩
        PropertyAnimation{
            target: gradient
            properties: 'horizontalOffset'
            from: -gradient.width
            to: gradient.width + gradient.horizontalRadius
            duration: 2000
            running: true
            loops: -1
        }
    }

}

