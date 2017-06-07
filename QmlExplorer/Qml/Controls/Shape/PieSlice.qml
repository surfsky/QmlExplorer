import QtQuick 2.0


/**
绘制一个饼图的切块
    /绘制
    把鼠标事件也弄进去
*/
Shape {
    width: 100
    height: 100
    border.width: 2

    property double start: 90;
    property double end: 180;

    onBuildPath: {
        var r = width/2;
        ctx.beginPath();
        ctx.arc(width/2, height/2, r, start*Math.PI/180.0, end*Math.PI/180.0);
        ctx.lineTo(width/2, height/2);
        ctx.closePath();
    }
}
