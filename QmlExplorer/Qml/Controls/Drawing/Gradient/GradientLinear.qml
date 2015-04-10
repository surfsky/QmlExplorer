import QtQuick 2.0


/**
线性渐变组件（使用Cavas实现任意方向的渐变，矩形）
官方的基于shader绘制
    import QtGraphicalEffects 1.0
    有BUG，无法指定方向（qt5.4）
*/
Canvas{
    width: 300; height: 300
    property point start : Qt.point(0, 0)
    property point end   : Qt.point(width, height)
    property Gradient gradient : Gradient {
        GradientStop { position: 0.0; color: "lightsteelblue" }
        GradientStop { position: 1.0; color: "blue" }
    }

    onPaint: {
        var ctx = getContext("2d");
        var grdt = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
        var stops = gradient.stops;
        for (var i=0; i<stops.length; i++)
        {
            var stop = stops[i];
            grdt.addColorStop(stop.position, stop.color);
        }
        ctx.fillStyle = grdt;
        ctx.fillRect(0, 0, width, height);
    }
}
