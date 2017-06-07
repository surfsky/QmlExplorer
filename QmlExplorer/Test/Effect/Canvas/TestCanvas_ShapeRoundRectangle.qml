import QtQuick 2.0
import QtQuick.Controls 1.2


/**
圆角矩形测试
*/
Item {
    id: container
    width: 320
    height: 480

    Column {
        spacing: 6
        anchors.fill: parent
        anchors.topMargin: 12
        Text {
            font.pointSize: 24
            font.bold: true
            text: "Squircles"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#777"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "|x-a|n + |y-b|n = |r|n"
            width: 250
            height: 25
        }

        Canvas {
            id: canvas
            width: 320
            height: 250
            antialiasing: true

            property color strokeStyle: Qt.darker(fillStyle, 1.2)
            property color fillStyle: "#6400aa"

            property int lineWidth: 2
            property int nSize: nCtrl.value
            property real radius: rCtrl.value
            property bool fill: true
            property bool stroke: false
            property real px: width/2
            property real py: height/2 + 10
            property real alpha: 1.0

            onRadiusChanged: requestPaint();
            onLineWidthChanged: requestPaint();
            onNSizeChanged: requestPaint();
            onFillChanged: requestPaint();
            onStrokeChanged: requestPaint();

            onPaint: squcirle();

            function squcirle() {
                var ctx = canvas.getContext("2d");
                var N = canvas.nSize;
                var R = canvas.radius;

                N=Math.abs(N);
                var M=N;
                if (N>100) M=100;
                if (N<0.00000000001) M=0.00000000001;

                ctx.save();
                ctx.globalAlpha =canvas.alpha;
                ctx.fillStyle = "white";
                ctx.fillRect(0, 0, canvas.width, canvas.height);

                ctx.strokeStyle = canvas.strokeStyle;
                ctx.fillStyle = canvas.fillStyle;
                ctx.lineWidth = canvas.lineWidth;

                ctx.beginPath();
                var i = 0, x, y;
                for (i=0; i<(2*R+1); i++){
                    x = Math.round(i-R) + canvas.px;
                    y = Math.round(Math.pow(Math.abs(Math.pow(R,M)-Math.pow(Math.abs(i-R),M)),1/M)) + canvas.py;

                    if (i == 0)
                        ctx.moveTo(x, y);
                    else
                        ctx.lineTo(x, y);
                }

                for (i=(2*R); i<(4*R+1); i++){
                    x =Math.round(3*R-i)+canvas.px;
                    y = Math.round(-Math.pow(Math.abs(Math.pow(R,M)-Math.pow(Math.abs(3*R-i),M)),1/M)) + canvas.py;
                    ctx.lineTo(x, y);
                }
                ctx.closePath();
                if (canvas.stroke) {
                    ctx.stroke();
                }

                if (canvas.fill) {
                    ctx.fill();
                }
                ctx.restore();
            }
        }

    }
    Column {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        Row{
            Text{text:"N"}
            Slider {id: nCtrl ; minimumValue: 1 ; maximumValue: 10 ; value: 2 ;}
        }
        Row{
            Text{text:"Radius"}
            Slider {id: rCtrl ; minimumValue: 30 ; maximumValue: 180 ; value: 60 ;}
        }
    }
}
