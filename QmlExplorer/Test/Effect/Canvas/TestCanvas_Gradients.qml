import QtQuick 2.0

/**
canvas渐变测试
可查看control/gradient/ 组件
*/
Canvas {
    id: root
    width: 300; height: 300
    onPaint: {
        var ctx = getContext("2d");
        var gradient = ctx.createLinearGradient(100,0,100,200);
        gradient.addColorStop(0, "blue");
        gradient.addColorStop(0.5, "lightsteelblue");
        ctx.fillStyle = gradient;
        ctx.fillRect(50,50,100,100);
    }
}
