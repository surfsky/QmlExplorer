import QtQuick 2.0


/**
Path 定义一个路径（包含若干线，若干路径元素）
    startX 、 startY 描述路径起点
    closed 是否闭合
    若干路径元素
        PathLine
        PathQuad
        PathCubic
        PathArc
        PathCurve
        PathSvg


路径元素属性
    x 、 y 属性，以绝对坐标的形式指定本段路径的终点；
    relativeX 、 relativeY 两个属性，以相对于起点的相对坐标的形式来指定终点。


PathView 至少需要设置三个属性
    model
    delegate
    path

*/
Column {
    id: root
    width: 600
    height: 600
    spacing: 10

    // 二次贝塞尔曲线示例
    Canvas {
        id: canvas
        width: 320;
        height: 240;

        // 绘制背景二次贝塞尔曲线
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = 2;
            ctx.strokeStyle = "red";
            ctx.beginPath();
            ctx.moveTo(16, 16);
            ctx.quadraticCurveTo(0, height - 1, width - 1, height - 1);
            ctx.moveTo(16, 16);
            ctx.bezierCurveTo(0, height - 1, width -1, height / 2, width - 16, height - 16);
            ctx.stroke();
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 100
            font.pixelSize: 20;
            text: "bezier curve";
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height - 10
            font.pixelSize: 20;
            text: "quadratic curve";
        }

        //-------------------------------------------
        // 小球点击后遵照贝塞尔曲线做动画
        //-------------------------------------------
        // 小球
        Rectangle {
            width: 32;
            height: 32;
            radius: 16;
            color: "blue";
            id: ball;
            MouseArea {
                anchors.fill: parent;
                id: mouseArea;
                onClicked: pathAnim.start();
            }
        }
        // 路径动画
        PathAnimation {
            id: pathAnim;
            target: ball;
            duration: 3000;
            anchorPoint: "16,16";
            easing.type: Easing.InCubic;
            path: Path {
                startX: 16;
                startY: 16;
                PathCubic {
                    x: canvas.width - 16;
                    y: canvas.height - 16;
                    control1X: 0;
                    control1Y: canvas.height - 1;
                    control2X: canvas.width - 1;
                    control2Y: canvas.height / 2;
                }
            }
        }
    }
}
