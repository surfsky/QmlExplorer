pragma Singleton
import QtQuick 2.0


/**
封装了Canvas绘图方法
理想的情况是要封装到js文件里面去，但js无法在qml目录中显示，很烦，就弄到这里了
js文件的封装请看qrc:/js/graphy.js
一些简写
    ctx : context
    p   : point
    c   : color
    w   : width
    h   : height
    t   : time
    a   : angle
*/
QtObject {
    // 清除指定矩形内的图像
    function clear(ctx, w, h){
        ctx.clearRect(0, 0, w, h);
    }

    function drawRect(ctx, color, p, w, h)
    {
        ctx.save();
        ctx.fillStyle = color;
        ctx.fillRect(p.x, p.y, w, h);
        ctx.restore();
    }

    function drawArc(ctx, color, width, p, r, angle1, angle2)
    {
        ctx.save();
        ctx.strokeStyle = color;
        ctx.lineWidth = width;
        ctx.beginPath();
        ctx.arc(p.x, p.y, r, Math.PI*angle1/180, Math.PI*angle2/180);
        ctx.stroke();
        ctx.restore();
    }

    function drawRound(ctx, color, p, r)
    {
        ctx.save();
        ctx.fillStyle = color;
        ctx.beginPath();
        ctx.arc(p.x, p.y, r, 0, 2*Math.PI);
        ctx.fill();
        ctx.restore();
    }

    function drawLine(ctx, color, width, p1, p2)
    {
        ctx.save();
        ctx.lineWidth = width
        ctx.strokeStyle = color
        ctx.beginPath()
        ctx.moveTo(p1.x, p1.y)
        ctx.lineTo(p2.x, p2.y)
        ctx.stroke()
        ctx.restore();
    }

    function drawBezier2(ctx, color, width, p1, p2, p3)
    {
        ctx.save();
        ctx.strokeStyle = color;
        ctx.lineWidth = width;

        ctx.beginPath();
        ctx.moveTo(p1.x, p1.y);
        ctx.quadraticCurveTo(p2.x, p2.y, p3.x, p3.y);
        ctx.stroke();
        ctx.restore();
    }

    function drawBezier3(ctx, color, width, p1, p2, p3, p4)
    {
        ctx.save();
        ctx.strokeStyle = color;
        ctx.lineWidth = width;

        ctx.beginPath();
        ctx.moveTo(p1.x, p1.y);
        ctx.bezierCurveTo(p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
        ctx.stroke();
        ctx.restore();
    }



    function getCurvePoint(p1, p2, p3, t)
    {
        var x = p1.x*(1-t)*(1-t) + p2.x*2*t*(1-t) + p3.x*t*t;
        var y = p1.y*(1-t)*(1-t) + p2.y*2*t*(1-t) + p3.y*t*t;
        return {x:x, y:y};
    }

    function getBezierPoint(p1, p2, p3, p4, t)
    {
        var x = p1.x*Math.pow(1-t, 3) + p2.x*3*t*Math.pow(1-t, 2) + p3.x*3*t*t*(1-t) + p4.x*t*t*t;
        var y = p1.y*Math.pow(1-t, 3) + p2.y*3*t*Math.pow(1-t, 2) + p3.y*3*t*t*(1-t) + p4.y*t*t*t;
        return {x:x, y:y};
    }
}
