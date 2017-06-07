import QtQuick 2.0

/**
绘制不规则圆角矩形
    /四个圆角半径可单独控制
        radius: "40,20,40,80";
        radius: 40;
    方向可控的 gradient
    border内陷绘制

lisence: MIT
authors: surfsky.cnblogs.com 2015-01
请保留此协议声明
*/
Shape {
    width: 100
    height: 100
    color: 'lightblue'
    border.width: 0
    border.color: 'red'
    property string radius: "40,20,40,80";
    //property string radius: "40";

    onBuildPath: {
        // radius
        var rs = radius.split(",");
        var p0,p1,p2,p3,r0,r1,r2,r3;
        if (rs.length == 1){
            r0 = r1 = r2 = r3 = rs[0];
            p0 = Qt.point(rs[0],       rs[0]);
            p1 = Qt.point(width-rs[0], rs[0]);
            p2 = Qt.point(width-rs[0], height-rs[0]);
            p3 = Qt.point(rs[0],       height-rs[0]);
        }
        else{
            r0 = rs[0];
            r1 = rs[1];
            r2 = rs[2];
            r3 = rs[3];
            p0 = Qt.point(rs[0],       rs[0]);
            p1 = Qt.point(width-rs[1], rs[1]);
            p2 = Qt.point(width-rs[2], height-rs[2]);
            p3 = Qt.point(rs[3],       height-rs[3]);
        }


        // path
        ctx.beginPath();
        ctx.arc(p0.x, p0.y, r0, Math.PI,     Math.PI*3/2); ctx.lineTo(p1.x,  0);
        ctx.arc(p1.x, p1.y, r1, Math.PI*3/2, Math.PI*2);   ctx.lineTo(width, p2.y);
        ctx.arc(p2.x, p2.y, r2, 0,           Math.PI/2);   ctx.lineTo(p3.x,  height);
        ctx.arc(p3.x, p3.y, r3, Math.PI/2,   Math.PI);     ctx.lineTo(0,     p0.y);
    }
}
