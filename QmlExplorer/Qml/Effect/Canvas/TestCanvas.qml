import QtQuick 2.0
import QtQuick.Controls 1.2

/**
canvas 基础绘图测试
canvas绘图可参考：
    http://www.cnblogs.com/tim-li/archive/2012/08/06/2580252.html
    http://qt-project.org/doc/qt-4.8/qtwebkit-guide-canvas.html
*/
Column{
    width: 600; height:600;
    spacing: 10

    // 保存图像
    Button{
        text: 'save as file'
        onClicked: {
            canvasLine.save('test.png');  // 直接存为图片
            img.source = 'test.png'
        }
    }
    Button {
        text: 'save as base64 image url'
        onClicked:{
            var url = canvasLine.toDataURL('image/png'); // 转化为base64编码
            print('image url=', url);
            img.source = url;
        }
    }
    Image{
        id:img
    }


    //---------------------------------------
    // Path 和基础描线功能测试
    //---------------------------------------
    Canvas {
        id: canvasLine
        width: 200; height: 200
        onPaint: {
            var ctx = getContext("2d")

            // path
            ctx.beginPath()     // start path
            ctx.moveTo(50,50)   // top-left
            ctx.lineTo(150,50)  // up line
            ctx.lineTo(150,150) // right line
            ctx.lineTo(50,150)  // bottom line
            ctx.closePath()     // close path

            // fill
            ctx.fillStyle = "steelblue"
            ctx.fill()

            // stroke
            ctx.lineWidth = 4
            ctx.strokeStyle = "green"
            ctx.stroke()
        }
    }

    //---------------------------------------
    // Canvas 绘制矩形
    //---------------------------------------
    Canvas {
        id: canvasRect
        width: 120; height: 120
        onPaint: {
            var ctx = getContext("2d")
            ctx.fillStyle = 'green'
            ctx.lineWidth = 4
            ctx.fillRect(20, 20, 80, 80)   // draw a filles rectangle
            ctx.clearRect(30, 30, 60, 60)  // cut our an inner rectangle
            ctx.strokeRect(20, 20, 40, 40) // stroke a border
        }
    }

    //---------------------------------------
    // Canvas 绘制圆形
    //---------------------------------------
    Canvas {
        width: 120; height: 120
        onPaint: {
            var ctx = getContext("2d")
            ctx.beginPath();
            ctx.arc(width/2, width/2, width/2, 0, Math.PI * 2, true);
            ctx.closePath();
            ctx.fillStyle = 'rgba(0,255,0,0.25)';
            ctx.fill();
        }
    }


    //---------------------------------------
    // Canvas 绘制贝塞尔曲线
    // Qml方式的path，可参考UI/DataView/TestPath_xxx相关示例
    //---------------------------------------
    Canvas {
        id: canvasCurve
        width: 200
        height: 200
        contextType: '2d'
        onPaint: {
            var ctx = context;
            //var ctx = canvas.getContext('2d');
            ctx.strokeStyle = Qt.rgba(1, 0, 0, 1);
            ctx.lineWidth = 1;
            ctx.beginPath();
            ctx.moveTo(20, 0);//start point
            ctx.bezierCurveTo(-10, 90, 210, 90, 180, 0);
            ctx.stroke();
        }
    }
}

