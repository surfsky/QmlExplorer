import QtQuick 2.0


/**
圆角图像效果组件
属性
    property string imagefile:"./images/bug.png"
    property int nSize:4      // 1-10
    property real radius:80   // 30-180
待完善：
    支持任意组件
    边缘圆滑
*/
Canvas {
    id: canvas
    width: 320
    height: 280
    // 共有属性
    property string imagefile:"./images/bug.png"
    property int nSize:4      // 1-10
    property real radius:80   // 30-180

    // 私有属性
    property color strokeStyle: Qt.darker(fillStyle, 1.2)
    property color fillStyle:"#14aaff" // green
    property int lineWidth:2
    property bool fill:true
    property bool stroke:false
    property real px: width/2
    property real py: height/2 + 20
    property real alpha: 1.0
    antialiasing: true
    Component.onCompleted:loadImage(canvas.imagefile);

    onRadiusChanged:requestPaint();
    onLineWidthChanged:requestPaint();
    onNSizeChanged:requestPaint();
    onFillChanged:requestPaint();
    onStrokeChanged:requestPaint();
    onImageLoaded : requestPaint();
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
        ctx.globalAlpha = canvas.alpha;
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

        //! [0]
        ctx.clip();
        ctx.drawImage(canvas.imagefile, 0, 0);
        //! [0]

        ctx.restore();
    }
}
