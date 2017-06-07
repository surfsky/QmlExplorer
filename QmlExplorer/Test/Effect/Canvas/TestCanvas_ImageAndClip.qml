import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.1
import QtGraphicalEffects 1.0


/**
canvas 绘制图像以及剪辑（clip）区域测试
*/
Item {
    id:mainRect
    width: 300
    height: 300


    property string imageUrl: "../images/bug.png"
    property color strokeColor: "lightgreen"


    Canvas {
        id: canvas
        anchors.fill: parent;
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 4;

            // 保存绘图上下文
            ctx.save();

            // 设置了一个路径
            ctx.beginPath();
            ctx.arc(mainRect.width/2, mainRect.height/2, mainRect.width/2, 0, Math.PI * 2, true);
            ctx.closePath();

            // 开启剪裁模式，在路径内绘制图片
            ctx.clip();
            ctx.drawImage(imageUrl, 0, 0);

            // 路径描边
            ctx.strokeStyle = strokeColor;
            ctx.stroke();

            // 恢复绘图上下文
            ctx.restore();
        }

        // canvas若涉及到drawimage操作，若不加上onImageLoaded事件，不会绘制图片
        //Component.onCompleted: canvas.loadImage(canvasimg);
        onImageLoaded: canvas.requestPaint();
    }
}
