import QtQuick 2.0


/**
用Canvas绘制饼图
qml图表可用QChart，示例见qchart.qrc
*/
Canvas
{
    id: canvas;
    height: 500;
    width: 500;
    onPaint:
    {
        var pieData = [
                    {value: 30,color:"#F38630"},
                    {value: 50,color: "#E0E4CC"},
                    {value: 100,color: "#69D2E7"},
                    {value: 80,color: "#123456"},
                    //只需要在这儿添加数据即可，要求value大于0
                    //{value: 40,color: "#654321"}
                ];

        drawPie(canvas.getContext("2d"), pieData);
    }

    function drawPie(context, data)
    {
        var width = context.canvas.width;
        var height = context.canvas.height;
        var ctx = context;
        var config = {
            segmentShowStroke : true,
            segmentStrokeColor : "#fff",
            segmentStrokeWidth : 2,
        };
        var segmentTotal = 0;
        var pieRadius = Math.min.apply(Math, [height/2, width/2]) - 5;
        for (var k=0; k<data.length; ++k)
        {
            segmentTotal += data[k].value;
        }
        var cumulativeAngle = -Math.PI/2;
        var scaleAnimation = 1;
        var rotateAnimation = 1;
        for (var i=0; i<data.length; ++i)
        {
            var segmentAngle = rotateAnimation*((data[i].value/segmentTotal)*(Math.PI*2));
            ctx.beginPath();
            ctx.arc(width/2, height/2, scaleAnimation * pieRadius,
                    cumulativeAngle, cumulativeAngle + segmentAngle);
            ctx.lineTo(width/2, height/2);
            ctx.closePath();
            ctx.fillStyle = data[i].color;
            ctx.fill();
            if(config.segmentShowStroke)
            {
                ctx.lineWidth = config.segmentStrokeWidth;
                ctx.strokeStyle = config.segmentStrokeColor;
                ctx.stroke();
            }
            cumulativeAngle += segmentAngle;
        }
    }
}
