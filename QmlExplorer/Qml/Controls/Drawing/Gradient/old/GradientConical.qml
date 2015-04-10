import QtQuick 2.0


/**
锥形渐变组件（使用Cavas实现任意方向的渐变）
*/
Canvas{
    property list<GradientStop> stops :[
        GradientStop { position: 0.0; color: "blue" },
        GradientStop { position: 1.0; color: "red" }
    ]

    anchors.fill: parent
    onPaint: {
        var ctx = getContext("2d")
        var gradient = ctx.createConicalGradient(
                    parent.width/2, parent.height/2, 360
                    )
        for (var i=0; i<stops.length; i++)
        {
            var stop = stops[i];
            gradient.addColorStop(stop.position, stop.color);
        }
        ctx.fillStyle = gradient
        ctx.fillRect(0, 0, parent.width, parent.height)
    }
}
