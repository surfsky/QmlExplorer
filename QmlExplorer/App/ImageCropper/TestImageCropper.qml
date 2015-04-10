import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.1


/**
加载图片并用遮罩方式选择其中的一部分
参考：http://blog.csdn.net/foruok/article/details/38778233
逻辑：
- 点击“Open”按钮打开一个对话框，用户选择一张图片
- 使用隐藏的Image对象加载, 加载成功后触发Canvas对象绘制图片；
- 当用户用手指（或按下鼠标左键）拖动时，选中框中心跟随手指移动，框内图像是正常亮度；
- 当用户抬起手指后，弹出操作菜单
- 如选择“Save”，则通过一个隐藏的Canvas把选中区域的图像保存到文件中。
*/
Window {
    visible: true
    width: 480;
    height: 320;
    minimumHeight: 320;
    minimumWidth: 480;
    color: "black";

    onWidthChanged: canvasMask.recalc();
    onHeightChanged: canvasMask.recalc();

    //------------------------------------------------
    // 原图像
    //------------------------------------------------
    Image {
        id: source;
        anchors.fill: parent;
        fillMode: Image.PreserveAspectFit;
        visible: false;
        asynchronous: true;
        onStatusChanged: {
            if(status == Image.Ready){
                console.log("image loaded");
                canvasMask.recalc();
            }
        }
    }
    FileDialog {
        id: fileDialog;
        title: "Please choose an Image File";
        nameFilters: ["Image Files (*.jpg *.png *.gif)"];
        onAccepted: {
            source.source = fileDialog.fileUrl;
        }
    }




    //------------------------------------------------
    // 图像选择遮罩
    //------------------------------------------------
    Canvas {
        id: canvasMask;
        anchors.fill: parent;
        z: 1;
        property real w: width;
        property real h: height;
        property real dx: 0;
        property real dy: 0;
        property real dw: 0;
        property real dh: 0;
        property real frameX: 66;
        property real frameY: 66;


        function getImageData(){
            return context.getImageData(frameX - 64, frameY - 64, 128, 128);
        }

        function recalc(){
            calc();
            requestPaint();
        }

        function calc(){
            var sw = source.sourceSize.width;
            var sh = source.sourceSize.height;
            if(sw > 0 && sh > 0){
                if(sw <= w && sh <=h){
                    dw = sw;
                    dh = sh;
                }else{
                    var sRatio = sw / sh;
                    dw = sRatio * h;
                    if(dw > w){
                        dh = w / sRatio;
                        dw = w;
                    }else{
                        dh = h;
                    }
                }
                dx = (w - dw)/2;
                dy = (h - dh)/2;
            }
        }



        onPaint: {
            var ctx = getContext("2d");

            // 无图像提示
            if(dw < 1 || dh < 1) {
                ctx.fillStyle = "#0000a0";
                ctx.font = "20pt sans-serif";
                ctx.textAlign = "center";
                ctx.fillText("Please Choose An Image File", width/2, height/2);
                return;
            }

            // 绘原图
            ctx.clearRect(0, 0, width, height);
            ctx.drawImage(source, dx, dy, dw, dh);
            var xStart = frameX - 66;
            var yStart = frameY - 66;
            ctx.save();

            // 绘制半透明遮罩（围绕取景框外围绘制4个半透明矩形）
            ctx.fillStyle = "#a0000000";
            ctx.fillRect(0, 0, w, yStart);
            var yOffset = yStart + 132;
            ctx.fillRect(0, yOffset, w, h - yOffset);
            ctx.fillRect(0, yStart, xStart, 132);
            var xOffset = xStart + 132;
            ctx.fillRect(xOffset, yStart, w - xOffset, 132);

            // 绘制取景框
            ctx.strokeStyle = "red";
            //ctx.fillStyle = "#00000000";
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.rect(xStart, yStart, 132, 132);
            //ctx.fill();
            ctx.stroke();
            ctx.closePath();
            ctx.restore();
        }
    }

    //------------------------------------------------
    // 截取图像区域（仅用于保存图像用）
    // canvas没有将区域图像保存为文件的直接方法，只能转化为另外一个canvas再保存
    //------------------------------------------------
    Canvas {
        id: canvasSave;
        width: 128;
        height: 128;
        contextType: "2d";
        visible: false;
        z: 2;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: 4;

        property var imageData: null;
        onPaint: {
            if(imageData != null){
                context.drawImage(imageData, 0, 0);
            }
        }
        function setImageData(data){
            imageData = data;
            requestPaint();
        }
    }

    //------------------------------------------------
    // 多点触摸区域：供用户选择范围（保存到mask.frameX/Y中)
    // 此处仅实现了一个点
    //------------------------------------------------
    MultiPointTouchArea {
        anchors.fill: parent;
        minimumTouchPoints: 1;
        maximumTouchPoints: 1;
        touchPoints:[
            TouchPoint{
                id: point1;
            }
        ]
        onUpdated: {
            canvasMask.frameX = point1.x;
            canvasMask.frameY = point1.y;
            canvasMask.requestPaint();
        }
        onReleased: {
            canvasSave.setImageData(canvasMask.getImageData());
            actionPanel.visible = true;
        }
        onPressed: {
            actionPanel.visible = false;
        }
    }

    //------------------------------------------------
    // 三个按钮：Open, Save, Close
    //------------------------------------------------
    Component {
        id: flatButton;
        ButtonStyle {
            background: Rectangle{
                implicitWidth: 70;
                implicitHeight: 30;
                border.width: control.hovered ? 2: 1;
                border.color: control.hovered ? "#c0c0c0" : "#909090";
                color: control.pressed ? "#a0a0a0" : "#707070";
            }
            label: Text {
                anchors.fill: parent;
                font.pointSize: 12;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                text: control.text;
                color: (control.hovered && !control.pressed) ? "blue": "white";
            }
        }
    }
    Row {
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 20;
        id: actionPanel;
        z: 5;
        spacing: 8;
        Button {
            style: flatButton;
            text: "Open";
            onClicked: fileDialog.open();
        }
        Button {
            style: flatButton;
            text: "Save";
            onClicked: {
                canvasSave.save("selected.png");
                actionPanel.visible = false;
            }
        }
        Button {
            style: flatButton;
            text: "Cancel";
            onClicked: actionPanel.visible = false;
        }
    }
}
