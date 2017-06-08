import QtQuick 2.0



/**
渐变组件（使用Cavas实现任意方向的渐变）
*/
Canvas{
    property point start : "0,0"
    property point end   : Qt.point(parent.width, parent.height)

    // 无法用default修饰符来简化，why？
    property list<GradientStop> stops :[
        GradientStop { position: 0.0; color: "blue" },
        GradientStop { position: 1.0; color: "red" }
    ]


    /*
    // 方式2也可以实现
    property Gradient gradient : Gradient {
        GradientStop { position: 0.0; color: "lightsteelblue" }
        GradientStop { position: 1.0; color: "blue" }
    }
    */


    anchors.fill: parent
    onPaint: {
        var ctx = getContext("2d")
        var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
        for (var i=0; i<stops.length; i++)
        {
            var stop = stops[i];
            //console.log(stop);
            gradient.addColorStop(stop.position, stop.color);
        }
        /*
        var children = gradient.stops
        for (var i=0; i<children.length; i++)
        {
            var stop = children[i];
            console.log(stop);
            gradient.addColorStop(stop.position, stop.color);
        }*/

        ctx.fillStyle = gradient
        ctx.fillRect(0, 0, parent.width, parent.height)
    }
}
