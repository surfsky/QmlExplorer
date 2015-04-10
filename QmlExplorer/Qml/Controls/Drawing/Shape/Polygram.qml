import QtQuick 2.0


/**
多边形
可以作为三角形、四边形、梯形、平行四边形的基类
*/
Shape {
    property var points : [
        Qt.point(0, 0),
        Qt.point(width, 0),
        Qt.point(80, height),
        Qt.point(60, height),
        Qt.point(60, height*2/3),
        Qt.point(20, height)
    ]

    onBuildPath: {
        ctx.beginPath();
        for (var i=0; i<points.length; i++){
            ctx.lineTo(points[i].x, points[i].y);
        }
        ctx.closePath();
    }
}
