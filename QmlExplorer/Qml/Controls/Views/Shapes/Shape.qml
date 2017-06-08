import QtQuick 2.0


/**
Shape 基类
    /含基础属性
        color
        border.width
        border.color
    /含区域处理事件（透明区不激活）
    /方向可控渐变
    /用回调函数简化代码：buildPath();
*/
Canvas {
    width: 100
    height: 100

    //-------------------------------------
    // 基础属性
    //-------------------------------------
    property bool shinkWhenPressed : true;
    property ShapeBorder border : ShapeBorder{width: 0; color: 'black'}
    property color color: 'lightgreen';
    property Gradient gradient : Gradient {
        GradientStop { position: 0.0; color: "lightsteelblue" }
        GradientStop { position: 1.0; color: "blue" }
    }
    property point gradientStart: Qt.point(0, 0);
    property point gradientEnd: Qt.point(width, 0);

    // 事件
    signal buildPath(var ctx);
    signal clicked(var mouse);


    //-------------------------------------
    // 绘制
    //-------------------------------------
    onPaint: {
        var ctx = getContext("2d");
        buildPath(ctx);
        drawBg(ctx);
        drawBorder(ctx);
    }

    // 根据当前path绘制背景（纯色或者渐变）
    function drawBg(ctx){
        if (gradient == null || gradient.stops.length == 0){
            ctx.fillStyle = color;
            ctx.fill();
        }
        else{
            //ctx.clip();
            var grdt = ctx.createLinearGradient(gradientStart.x, gradientStart.y, gradientEnd.x, gradientEnd.y);
            var stops = gradient.stops;
            for (var i=0; i<stops.length; i++)
            {
                var stop = stops[i];
                grdt.addColorStop(stop.position, stop.color);
            }
            ctx.fillStyle = grdt;
            ctx.fill();
        }
    }

    // 绘制边框
    function drawBorder(ctx){
        if (border.width > 0){
            ctx.lineWidth = border.width;
            ctx.strokeStyle = border.color;
            ctx.stroke();
        }
    }

    //-------------------------------------
    // 鼠标点击事件（仅非透明区域才触发）
    //-------------------------------------
    // 当前点是否是透明的，请在鼠标事件中调用
    function isCurrentPointTransparent(){
        var x = area.mouseX;
        var y = area.mouseY;
        var p = getContext("2d").getImageData(x, y, 1, 1).data;
        var a = p[3];
        //console.log(a);
        return (a==0);
    }

    MouseArea{
        id: area
        anchors.fill: parent
        onPressed: {
            if (!isCurrentPointTransparent() && shinkWhenPressed)
                parent.scale = 0.9;
        }
        onExited: parent.scale = 1.0;
        onClicked: {
            if (!isCurrentPointTransparent())
            {
                mouse.accepted = true;
                parent.clicked(mouse);
            }
        }
    }
}
