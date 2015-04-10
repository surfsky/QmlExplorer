.pragma library

//------------------------------------------
// 辅助绘图方法
//------------------------------------------
// 计算两点夹角
function getAngle(pt1, pt2){
    var angle = 0;
    if (pt2.x == pt1.x)
        angle = (pt2.y > pt1.y) ? Math.PI/2 : -Math.PI/2;
    else if (pt2.y == pt1.y)
        angle = (pt2.x > pt1.x) ? 0 : Math.PI;
    else if (pt2.x < pt1.x)
        angle = Math.PI + Math.atan((pt2.y - pt1.y)/(pt2.x - pt1.x));
    else
        angle = Math.atan((pt2.y - pt1.y)/(pt2.x - pt1.x));
    return (angle < 0) ? angle+Math.PI*2 : angle;
}

// 清屏
function clear(ctx){
    ctx.clearRect(0, 0, width, height);
}

// 绘圆
function drawRound(ctx, p, r){
    ctx.beginPath();
    ctx.arc(p.x, p.y, r, 0, 2*Math.PI, false);
    ctx.stroke();
}

// 绘制线段（极坐标方式）
function drawLine(ctx, p, r, angle){
    var x = p.x + Math.cos(angle)*r;
    var y = p.y + Math.sin(angle)*r;
    ctx.beginPath();
    ctx.moveTo(p.x, p.y)
    ctx.lineTo(x, y);
    ctx.stroke();
}
