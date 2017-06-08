import QtQuick 2.0


/**
圆形
*/
Shape {
    property int radius: 50
    width: radius*2;
    height: radius*2

    onBuildPath: {
        ctx.beginPath();
        ctx.arc(width/2, height/2, radius, 0, 2*Math.PI);
    }
}
