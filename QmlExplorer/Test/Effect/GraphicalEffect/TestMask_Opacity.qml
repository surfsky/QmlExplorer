import QtQuick 2.0
import QtGraphicalEffects 1.0


/**
测试OpacityMask
- 这东西可以生成一个图片（只是图片，并非不规则遮罩）
- 源对象可以是任何元素
- 遮罩对象是一个Item（可以是png图片、rectangle等）
*/
Column {
    id: root
    width: 300
    height: 600
    spacing: 10

    // 用png图片做遮罩
    OpacityMask {
        width: 300;height:300
        source: Image {source: "../images/bug.png"}
        maskSource: Image {source: "../images/butterfly.png"}
    }

    // 圆形遮罩
    OpacityMask {
        width: 300;height:300
        source: Image {source: "../images/bug.png"}
        maskSource: Rectangle{
            width: 300; height:300
            color: 'white' //'black'
            radius: width/2
        }
    }
}
