import QtQuick 2.0


/**
\title 图像鼠标区域（可获取点击点的像素是否是透明的）
\qml
    Image{
        source: 'pentagon.png'
        anchors.centerIn: parent;
        ImageMouseArea{
            imageUrl: 'pentagon.png'
            anchors.fill: parent
            onPressed: {
                if (!isCurrentPointTransparent())
                    console.log('pressed')
            }
        }
    }
*/
MouseArea {
    anchors.fill: parent

    // png图片
    property alias imageUrl: canvas.imageUrl

    // 当前点是否是透明的，请在鼠标事件中调用
    function isCurrentPointTransparent(){
        return canvas.isTransparent(mouseX, mouseY);
    }

    // 用canvas保存图像信息，并用于点击检测
    Canvas {
        id: canvas;
        anchors.fill: parent
        contextType: "2d";
        visible: false;
        z: 2;

        property string imageUrl: 'roundmenu.png';
        function isTransparent(x, y){
            if (imageUrl == null)
                return true;
            else{
                var p = context.getImageData(x, y, 1, 1).data;
                var r = p[0];
                var g = p[1];
                var b = p[2];
                var a = p[3];
                console.debug("(" + x + "," + y + "): "+  r + "," + g + ',' + b + ',' + a);
                return (a==0);
            }
        }

        onPaint: {
            if(imageUrl != null){
                context.drawImage(imageUrl, 0, 0);
            }
        }
    }
}
