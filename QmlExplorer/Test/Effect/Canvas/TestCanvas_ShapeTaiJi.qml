import QtQuick 2.0


/**
太极阴阳鱼图案
*/
Canvas {
    width: 400
    height: 400


    onPaint: {
        var ctx = getContext('2d');
        var cx = width/2;
        var cy = height/2;
        var r = width/2
        var a1 = {x:cx, y:cy, r:r};
        var a2 = {x:cx, y:cy, r:r};
        var a3 = {x:cx, y:cy+r/2, r:r/2};
        var a4 = {x:cx, y:cy-r/2, r:r/2};
        var a5 = {x:cx, y:cy-r/2, r:r/16};
        var a6 = {x:cx, y:cy+r/2, r:r/16};

        //绘制白色半圆的代码如下：
        ctx.beginPath();
        ctx.arc(a1.x, a1.y, a1.r,1.5*Math.PI, Math.PI/2,false);
        ctx.fillStyle="white";
        ctx.closePath();
        ctx.fill();

        //绘制黑色半圆的代码如下：
        ctx.beginPath();
        ctx.arc(a2.x, a2.y, a2.r, Math.PI/2,1.5*Math.PI,false);
        ctx.fillStyle="black";
        ctx.closePath();
        ctx.fill();

        //绘制黑色小圆
        ctx.beginPath();
        ctx.arc(a3.x, a3.y, a3.r, 0,Math.PI*2,true);
        ctx.fillStyle="black";
        ctx.closePath();
        ctx.fill();

        //绘制白色小圆
        ctx.beginPath();
        ctx.arc(a4.x ,a4.y, a4.r, 0,Math.PI*2,true);
        ctx.fillStyle="white";
        ctx.closePath();
        ctx.fill();

        //绘制白色小圆心
        ctx.beginPath();
        ctx.arc(a5.x, a5.y, a5.r, 0,Math.PI*2,true);
        ctx.fillStyle="black";
        ctx.closePath();
        ctx.fill();

        //绘制黑色小圆心
        ctx.beginPath();
        ctx.arc(a6.x, a6.y, a6.r, 0,Math.PI*2,true);
        ctx.fillStyle="white";
        ctx.closePath();
        ctx.fill();
    }
}
