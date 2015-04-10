import QtQuick 2.0


/**
角度选择器
*/
Canvas {
    id: root
    width: 40; height: 40

    // 垂直向下为90度
    property double value: 90;           // 角度
    property double angle : Math.PI/2;   // 弧度
    onValueChanged: {
        angle = value*Math.PI/180;
    }
    onAngleChanged: {
        value = angle*180/Math.PI;
    }

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

    //------------------------------------------
    // 绘图和事件
    //------------------------------------------
    onPaint: {
        var ctx = getContext("2d")
        var r = width/2;
        var p = {x:width/2, y:width/2};
        ctx.lineWidth = 1
        ctx.strokeStyle="#c0c0c0";

        // 绘圆、绘角度
        clear(ctx);
        drawRound(ctx, p, r);
        drawLine(ctx, p, r, root.angle);
    }
    MouseArea{
        id: area
        anchors.fill: parent;
        onPressed: calAngle();
        onPositionChanged: {if (area.pressed) calAngle();}
        function calAngle(){
            var p1 = {x:root.width/2, y:root.width/2};
            var p2 = {x:mouseX, y:mouseY};
            if (p1 == p2) return;
            root.angle = root.getAngle(p1, p2);
            console.log(root.angle + ": " + root.angle*180/Math.PI);
            root.requestPaint();
        }
    }

}
