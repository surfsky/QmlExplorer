import QtQuick 2.0
import QtQuick.Controls 1.2

/**
演示路径的写法
- 一个下拉框供选择路径类型
- 点击按钮，小圆球按照指定路径做动画
- 绘制小球运动轨迹（how？）背景放一个全屏的canvas，监视小球位置？
*/
Rectangle{
    id: root
    width: 800
    height: 800


    //--------------------------------------
    // 绘制轨迹
    //--------------------------------------
    Canvas {
        id: canvas
        z: 0
        anchors.fill: parent
        property int lastX;
        property int lastY;
        // 绘线：从最后位置到当前鼠标位置
        onPaint: {
            var ctx = getContext('2d');
            ctx.lineWidth = 2;
            ctx.strokeStyle = 'red';
            ctx.beginPath();
            ctx.moveTo(lastX, lastY);
            lastX = ball.x;
            lastY = ball.y;
            ctx.lineTo(lastX, lastY);
            ctx.stroke();
        }
        function clear(){
            lastX = 0;
            lastY = 0;
            var ctx = getContext('2d');
            ctx.fillStyle="#ffffff";
            ctx.fillRect(0, 0, width, height);
        }
    }

    //--------------------------------------
    // 小球和动画
    //--------------------------------------
    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        width: 200
        height: 50;
        spacing: 10
        ComboBox{
            id: cmb
            model: ['arc1', 'arc2', 'arc3', 'arc4', 'line', 'quad', 'cubic', 'custom1', 'custom2']
        }
        Button{
            text: 'go'
            onClicked: animPath.start();
        }
    }

    // 小球和动画
    Rectangle {
        id: ball;
        width: 32;
        height: 32;
        radius: 16;
        color: "blue";

        onXChanged: canvas.requestPaint()
        onYChanged: canvas.requestPaint()
    }

    // 路径动画
    PathAnimation {
        id: animPath;
        target: ball;
        duration: 1000;
        anchorPoint: "16,16";
        easing.type: Easing.Linear; //.InCubic;
        path: getPath(cmb.currentText)
        onStarted: canvas.clear();
    }



    //--------------------------------------
    // 各种路径
    //--------------------------------------
    function getPath(pathName)
    {
        switch(pathName){
            case 'arc1': return arc1;
            case 'arc2': return arc2;
            case 'arc3': return arc3;
            case 'arc4': return arc4;
            case 'line': return line;
            case 'quad': return quad;
            case 'cubic': return cubic;
            case 'custom1': return custom1;
            case 'custom2': return custom2;
            default: return arc1;
        }
    }

    // 4个圆弧路径
    Path {
        id: arc1
        startX: 100; startY: 0
        PathArc {
            x: 0; y: 100
            radiusX: 100; radiusY: 100
            useLargeArc: true
        }
    }

    Path {
        id: arc2
        startX: 50; startY: 50
        PathArc {
            x: 150; y: 50
            radiusX: 75; radiusY: 50
        }
    }

    Path {
        id: arc3
        startX: 0; startY: 100
        PathArc {
            relativeX: 50; y: 100
            radiusX: 25; radiusY: 15
        }
        PathArc {
            relativeX: 50; y: 100
            radiusX: 25; radiusY: 25
        }
        PathArc {
            relativeX: 50; y: 100
            radiusX: 25; radiusY: 50
        }
        PathArc {
            relativeX: 50; y: 100
            radiusX: 50; radiusY: 100
        }
    }


    Path {
        id: arc4
        startX: 0; startY: 100
        PathArc {
            x: 100; y: 200
            radiusX: 100; radiusY: 100
            direction: PathArc.Clockwise
            useLargeArc: true
        }
    }

    // 直线
    Path {
        id: line
        startX: 0;
        startY: 0;
        PathLine {
            x: root.width - 1;
            y: root.height - 1;
        }
    }

    // 二次贝塞尔曲线有1个控制点
    Path {
        id: quad
        startX: 0;
        startY: 0;
        PathQuad {
            x: root.width - 1;
            y: root.height - 1;
            controlX: 0;
            controlY: root.height - 1;
        }
    }

    // 三次贝塞尔曲线有两个控制点
    Path {
        id:cubic
        startX: 0;
        startY: 0;
        PathCubic {
            x: root.width - 16;
            y: root.height - 16;
            control1X: 0;
            control1Y: root.height - 1;
            control2X: root.width - 1;
            control2Y: root.height / 2;
        }
    }

    // 自绘路径(PathAttribute)
    Path {
        id: custom1
        startX: 10;
        startY: 100;
        PathAttribute { name: "zOrder"; value: 0 }
        PathAttribute { name: "itemAlpha"; value: 0.1 }
        PathAttribute { name: "itemScale"; value: 0.6 }
        PathLine {
            x: root.width/2 - 40;
            y: 100;
        }
        PathAttribute { name: "zOrder"; value: 10 }
        PathAttribute { name: "itemAlpha"; value: 0.8 }
        PathAttribute { name: "itemScale"; value: 1.2 }
        PathLine {
            relativeX: root.width/2 - 60;
            relativeY: 0;
        }
        PathAttribute { name: "zOrder"; value: 0 }
        PathAttribute { name: "itemAlpha"; value: 0.1 }
        PathAttribute { name: "itemScale"; value: 0.6 }
    }

    // PathPercent
    Path {
        id: custom2
        startX: 10;
        startY: 100;
        PathLine {
            x: root.width/2 - 40;
            y: 100;
        }
        PathPercent { value: 0.28; }
        PathLine {
            relativeX: root.width/2 - 60;
            relativeY: 0;
        }
    }
}

