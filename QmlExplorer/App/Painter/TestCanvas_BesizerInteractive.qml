import QtQuick 2.0
import QtQuick.Controls 1.2
import "."

/**
鼠标互动绘制贝塞尔曲线示例
更复杂的示例可看：贝塞尔教学游戏
*/
Rectangle
{
    id: root
    width: 600; height:600
    color: 'black'

    // 绘图区
    Canvas {
        id: canvas
        anchors.fill: parent


        property real lastX
        property real lastY
        property var  lastImage;


        // 绘线：从最后位置到当前鼠标位置
        onPaint: {
            var ctx = getContext('2d')

            // 绘线并保存为图像
            drawBg(ctx, 'black');

            var p1 = {x:lastX, y:lastY};
            var p2 = {x:rect2.x+rect2.width/2, y:rect2.y+rect2.height/2};
            var p3 = {x:rect3.x+rect3.width/2, y:rect3.y+rect3.height/2};
            var p4 = {x:area.mouseX, y:area.mouseY};


            G.drawBezier3(ctx, 'red', 2, p1, p2, p3, p4);
            G.drawRound(ctx, 'green', p1, 5);
            G.drawRound(ctx, 'green', p4, 5);
            G.drawLine(ctx, 'green', 2, p1, p2);
            G.drawLine(ctx, 'green', 2, p3, p4);
        }


        function drawBg(ctx, color)
        {
            ctx.save();
            ctx.fillStyle = color;
            ctx.fillRect(0, 0, width, height);
            ctx.restore();
        }



        // 记录下最后的鼠标点，并请求canvas重绘
        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                canvas.lastX = mouseX;
                canvas.lastY = mouseY;
            }
            onPositionChanged: {
                canvas.requestPaint()
            }
            onReleased: {
                //canvas.lastImage = canvas.getContext('2d').getImageData(0, 0, width, height);
                //console.log("save image");
            }
        }
    }

    //----------------------------------------
    // 两个控制点
    //----------------------------------------
    // 控制点1
    Rectangle {
        id: rect2
        color: "yellow"
        x: 100; y : 100
        width: 10; height: 10
        radius: 5
        MouseArea {
            anchors.fill: parent
            drag.target: parent
        }
        onXChanged: canvas.requestPaint();
        onYChanged: canvas.requestPaint();
    }

    // 控制点2
    Rectangle {
        id: rect3
        color: "yellow"
        x: 200; y : 100
        width: 10; height: 10
        radius: 5
        MouseArea {
            anchors.fill: parent
            drag.target: parent
        }
        onXChanged: canvas.requestPaint();
        onYChanged: canvas.requestPaint();
    }


    //----------------------------------------
    // 生成组件
    //----------------------------------------
    Component{
        id: cmp
        Rectangle{
            width: 10
            height: 10
            radius: 5
            color: 'blue'
        }
    }
    Item{
        id: itemLayer
        anchors.fill: parent
    }

    Button {
        text: '生成'
        x: 10; y:10
        width: 100; height:20
        onClicked:{
            clearChildren(itemLayer);

            var p1 = {x:canvas.lastX, y:canvas.lastY};
            var p2 = {x:rect2.x+rect2.width/2, y:rect2.y+rect2.height/2};
            var p3 = {x:rect3.x+rect3.width/2, y:rect3.y+rect3.height/2};
            var p4 = {x:area.mouseX, y:area.mouseY};

            for (var t=0.0; t<1.0; t+=0.1)
            {
                var item = cmp.createObject(itemLayer);
                var p = G.getBezierPoint(p1, p2, p3, p4, t);
                item.x = p.x - item.width/2;
                item.y = p.y - item.height/2;
            }
        }

        // 清除子元素
        function clearChildren(parent)
        {
            var children = parent.children;
            for (var i = 0; i < children.length; i++)
            {
                children[i].destroy();
            }
        }
    }
}
