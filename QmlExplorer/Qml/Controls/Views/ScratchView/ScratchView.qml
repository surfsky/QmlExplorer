import QtQuick 2.0

/**
刮刮卡视图
表层是一层色彩，用手指划开，可看到下面的文字
Lisence: MIT, 请保留本文档说明
Author: surfsky.cnblogs.com 2015-02
*/
Item {
    id: root
    width: 500
    height: 200

    // 公共属性
    property alias text : lbl.text;       // 刮刮卡下面的文字
    property color maskColor : 'green';   // 遮罩色彩

    // 文字
    Text{
        id: lbl
        text: '特等奖：9999999元'
        anchors.centerIn: parent
        font.pointSize: 20
    }

    // 默认显示一张图片。用手指刮去（触摸部分设置为透明即可）
    // 绘图区
    Canvas {
        id: canvas
        anchors.fill: parent

        //
        property bool isFirstPaint : true;
        property point lastPt;

        //
        onPaint: {
            var ctx = getContext('2d');
            if (isFirstPaint){
                // 首次绘制刮刮层图案
                ctx.fillStyle = root.maskColor;
                ctx.fillRect(0, 0, width, height);
                isFirstPaint = false;
            }
            else{
                // 去除鼠标位置的图案
                clearRound(ctx, lastPt, 20);
                lastPt = Qt.point(area.mouseX, area.mouseY);
            }
        }

        // 清除圆形区域
        function clearRound(ctx, p, r)
        {
            ctx.save();
            ctx.globalCompositeOperation = 'destination-out';
            ctx.beginPath();
            ctx.arc(p.x, p.y, r, 0, 2*Math.PI, false);
            ctx.fill();
            ctx.restore();
        }

        // 记录下最后的鼠标点，并请求canvas重绘
        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {canvas.lastPt = Qt.point(mouseX, mouseY);}
            onPositionChanged: {canvas.requestPaint();}
        }
    }
}
