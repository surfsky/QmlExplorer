import QtQuick 2.0

Image {
    id: root
    width: 800
    height: 600
    source: "../Images/tree.jpg"

    // 距离边界宽度
    property int d : 50

    // 中空蒙版层
    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var w = width;
            var h = height;
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, w, h);
            ctx.fillStyle = '#99ffffff';
            ctx.fillRect(0,   0, w, d);
            ctx.fillRect(0,   d, d, h-2*d);
            ctx.fillRect(w-d, d, d, h-2*d);
            ctx.fillRect(0,  h-d, w, d);
        }
    }
}

