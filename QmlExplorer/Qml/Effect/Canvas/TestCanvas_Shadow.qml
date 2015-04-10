import QtQuick 2.0

/**
canvas 阴影效果测试
*/
Canvas {
    id: canvas
    width: 300; height: 300
    onPaint: {
        var ctx = getContext("2d")
        //ctx.fillRect(0, 0, canvas.width, canvas.height);

        // shadow
        ctx.shadowColor = "blue";
        ctx.shadowOffsetX = 2;
        ctx.shadowOffsetY = 2;
        ctx.shadowBlur = 2;

        // stroke
        ctx.strokeStyle = "#333"

        // text
        ctx.font = "bold 17px sans-serif";
        ctx.fillStyle = 'black';  //"#33a9ff";
        ctx.fillText("Earth", 100, 100);
    }
}
