import QtQuick 2.0


/**
圆环渐变组件（使用Cavas实现任意方向的渐变，矩形）
官方的基于shader绘制
    import QtGraphicalEffects 1.0
*/
Canvas{
    width: 300; height:300;
    property point start : Qt.point(width/2, height/2)
    property double radius : width;
    property Gradient gradient: Gradient{
        GradientStop { position: 0.0; color: "blue" }
        GradientStop { position: 0.5; color: "lightblue" }
        GradientStop { position: 1.0; color: "white" }
    }
    onGradientChanged: requestPaint();

    onPaint: {
        var ctx = getContext("2d")
        var grdt = ctx.createRadialGradient(
                    start.x, start.y, 0,
                    start.x, start.y, radius
                    )
        var stops = gradient.stops;
        for (var i=0; i<stops.length; i++)
        {
            var stop = stops[i];
            grdt.addColorStop(stop.position, stop.color);
        }
        ctx.fillStyle = grdt
        ctx.fillRect(0, 0, width, height)
    }
}
