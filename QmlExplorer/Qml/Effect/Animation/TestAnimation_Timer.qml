import QtQuick 2.3

/**
测试动画（直接用Animation vs 用Timer）
20个大小矩形，边旋转变更改颜色
*/
Repeater {
    width: 500; height:500
    model: 20
    delegate:
        Rectangle {
            id: rect
            width: 20 * index
            height: 20 * index
            anchors.centerIn: parent
            opacity: 0.2

            // 色彩
            color: colors[currentColor]
            property var colors: ["red", "orange", "green", "blue"]
            property int currentColor: 0

            // 用Animation修改角度（连续动画）
            NumberAnimation on rotation {
                id: animation
                from: 0
                to: 360
                duration: 400 * index
                loops: NumberAnimation.Infinite
            }

            // 用timer定时更改色彩
            Behavior on color { PropertyAnimation { duration: 2000 } }
            Timer {
                interval: 4000
                repeat: true
                triggeredOnStart: true
                running: true
                onTriggered: {
                    if (rect.currentColor == rect.colors.length - 1)
                        rect.currentColor = 0
                    rect.currentColor++
                }
            }
        }
}
