/**
读取canvas数据
    createImageData(sw,sh)或者getImageData(sx,sy,sw,sh)
    两个方法都返回 ImageData 对象（含 width, height ，data属性）
    data 属性包含了一维RGBA像素数组，值范围 0 到 255
设置canvas数据
    putImageData(imagedata, x, y)
保存canvas为图像
    canvas.save(path)
    canvas.toDataURL(mimeType)

以下示例
    在canvas上绘制若干圆点
    点击canvas后会将canvas图片保存为image url
    右侧的Image控件将显示该图像
*/
import QtQuick 2.0
Rectangle {
    width: 240; height: 120
    Canvas {
        id: canvas
        x: 10; y: 10
        width: 100; height: 100
        property real hue: 0.0

        onPaint: {
            var ctx = getContext("2d")

            // 色彩
            hue += Math.random()*0.1
            if(hue > 1.0) { hue -= 1 }
            ctx.fillStyle = Qt.hsla(hue, 0.5, 0.5, 1.0)
            ctx.globalAlpha = 0.7

            // 位置
            var x = 10 + Math.random(80)*80
            var y = 10 + Math.random(80)*80
            ctx.beginPath()
            ctx.moveTo(x+5,y)
            ctx.arc(x,y, x/10, 0, 360)   // 其实就是画了个圆
            ctx.closePath()
            ctx.fill()
        }

        // 点击canvas，将canvas图片保存到image
        MouseArea {
            anchors.fill: parent
            onClicked: {
                var url = canvas.toDataURL('image/png'); // 转化为base64编码
                print('image url=', url);
                image.source = url;
            }
        }
    }
    Image {
        id: image
        x: 130; y: 10
        width: 100; height: 100
    }
    Timer {
        interval: 1000
        running: true
        triggeredOnStart: true
        repeat: true
        onTriggered: canvas.requestPaint()
    }
}
