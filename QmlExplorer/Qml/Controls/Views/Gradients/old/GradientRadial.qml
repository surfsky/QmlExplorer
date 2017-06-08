import QtQuick 2.0


/**
圆环渐变组件
*/
Canvas{
    property point start : Qt.point(parent.width/2, parent.height/2)
    property double radius : parent.width;
    property list<GradientStop> stops :[
        GradientStop { position: 0.0; color: "blue" },
        GradientStop { position: 1.0; color: "lightblue" }
    ]

    anchors.fill: parent

    onPaint: {
        var ctx = getContext("2d")
        var gradient = ctx.createRadialGradient(
                    start.x, start.y, 0,
                    start.x, start.y, radius
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
