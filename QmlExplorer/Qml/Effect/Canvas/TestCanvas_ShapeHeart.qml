import QtQuick 2.0


/**
测试Canvas（画了个心）
更复杂的绘图代码请参考qt自带的示例项目“canvas”
主要就是重载onPaint方法
    onPaint: {
        var ctx = canvas.getContext('2d');
*/
Rectangle {
    width: 640
    height: 480

    Canvas {
        id:canvas
        width:320
        height:280
        property color strokeStyle:  Qt.lighter(fillStyle, 1.4)
        property color fillStyle: "#b40000" // red
        property int lineWidth: 4
        property bool fill: true
        property bool stroke: true
        property real alpha: 1.0
        property real scale : 1.2
        property real rotate : 0
        antialiasing: true

        onLineWidthChanged:requestPaint();
        onFillChanged:requestPaint();
        onStrokeChanged:requestPaint();
        onScaleChanged:requestPaint();
        onRotateChanged:requestPaint();

        onPaint: {
            var ctx = canvas.getContext('2d');
            var originX = 85
            var originY = 75
            ctx.save();
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.translate(originX, originX);
            ctx.globalAlpha = canvas.alpha;
            ctx.strokeStyle = canvas.strokeStyle;
            ctx.fillStyle = canvas.fillStyle;
            ctx.lineWidth = canvas.lineWidth;

            ctx.translate(originX, originY)
            ctx.scale(canvas.scale, canvas.scale);
            ctx.rotate(canvas.rotate);
            ctx.translate(-originX, -originY)

            ctx.beginPath();
            ctx.moveTo(75,40);
            ctx.bezierCurveTo(75,37,70,25,50,25);
            ctx.bezierCurveTo(20,25,20,62.5,20,62.5);
            ctx.bezierCurveTo(20,80,40,102,75,120);
            ctx.bezierCurveTo(110,102,130,80,130,62.5);
            ctx.bezierCurveTo(130,62.5,130,25,100,25);
            ctx.bezierCurveTo(85,25,75,37,75,40);
            ctx.closePath();
            if (canvas.fill)
                ctx.fill();
            if (canvas.stroke)
                ctx.stroke();
            ctx.restore();
        }
    }
}
