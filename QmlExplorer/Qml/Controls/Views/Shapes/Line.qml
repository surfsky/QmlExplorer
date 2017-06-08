import QtQuick 2.0


/**
线
*/
Shape {
    width: 100
    height: 1
    border.width: 1;
    property point start : Qt.point(0, 0);
    property point end: Qt.point(width, height);
    onBuildPath: {
        ctx.beginPath();
        ctx.moveTo(start.x, start.y);
        ctx.lineTo(end.x, end.y);
    }
}
