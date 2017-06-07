import QtQuick 2.0

/**
图像混合模式测试
*/
Canvas {
    id: root
    width: 600; height: 500

    property var operation : [
        'source-over', 'source-in', 'source-over',
        'source-atop', 'destination-over', 'destination-in',
        'destination-out', 'destination-atop', 'lighter',
        'copy', 'xor', 'qt-clear', 'qt-destination',
        'qt-multiply', 'qt-screen', 'qt-overlay', 'qt-darken',
        'qt-lighten', 'qt-color-dodge', 'qt-color-burn',
        'qt-hard-light', 'qt-soft-light', 'qt-difference',
        'qt-exclusion'
        ]

    onPaint: {
        var ctx = getContext('2d')
        for(var i=0; i<operation.length; i++) {
            // 位移
            var dx = Math.floor(i%6)*100
            var dy = Math.floor(i/6)*100

            // 保存绘图环境
            ctx.save()

            // 第一个物体
            ctx.fillStyle = '#33a9ff'
            ctx.fillRect(10+dx,10+dy,60,60)

            // 图像混合模式
            ctx.globalCompositeOperation = root.operation[i]

            // 第二个物体
            ctx.fillStyle = '#ff33a9'
            ctx.globalAlpha = 0.75
            ctx.beginPath()
            ctx.arc(60+dx, 60+dy, 30, 0, 2*Math.PI)
            ctx.closePath()
            ctx.fill()

            // 恢复绘图环境
            ctx.restore()

            // 文本
            ctx.fillText(root.operation[i], 20+dx, 100+dy);
        }
    }
}
