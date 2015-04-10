import QtQuick 2.0
import QtQuick.Controls 1.2

/**
九宫格划指锁屏视图
Lisence: MIT, 请保留本文档说明
Author: surfsky.cnblogs.com 2015-02
*/
Rectangle {
    id: root
    width: 500
    height: 600


    // 公共属性
    property string password : getPassword();

    // 私有变量
    property var lockPoints : [];    // 锁屏密码点数组
    property int ptWidth : 100;      // 密码点宽度
    property int ptLineWidth : 12;   // 密码连线宽度


    //---------------------------------------
    // 方法
    //---------------------------------------
    // 检测当前鼠标位置是否在某个锁点上，若有必要，添加锁点
    function checkLockPoints(){
        var p = Qt.point(area.mouseX, area.mouseY);
        //console.log(p);
        for (var i=0; i<grid.children.length; i++){
            var item = grid.children[i];
            var rect = Qt.rect(item.x, item.y, item.width, item.height);
            //console.log(rect);
            if (isInRect(p, rect)){
                console.log(item.lockId);
                if (!item.locked){
                    item.locked = true;
                    lockPoints.push(item);
                    lbl.text = '密码：' + getPassword();
                    break;
                }
            }
        }
    }

    // 某个点是否在指定区域内
    function isInRect(p, rect){
        return  p.x >= rect.x
             && p.x <= rect.x+rect.width
             && p.y >= rect.y
             && p.y <= rect.y+rect.height
    }

    // 获取密码
    function getPassword(){
        var text = '';
        for (var i=0; i<lockPoints.length; i++){
            var lockPoint = lockPoints[i];
            text += lockPoint.lockId;
        }
        return text;
    }

    // 重置密码
    function clearPassword(){
        for (var i=0; i<grid.children.length; i++){
            var item = grid.children[i];
            item.locked = false;
        }
        lockPoints = [];
        canvas.requestPaint();
    }

    //---------------------------------------
    // UI
    //---------------------------------------
    Row{
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
        y: 50
        // 密码
        Text{
            id: lbl
            font.pointSize: 20
            font.bold: true
        }
        // 重置
        Button{
            text: '重置'
            onClicked: clearPassword();
        }
    }


    //----------------------------------
    // 放置9个圆点
    //----------------------------------
    Grid{
        id: grid
        width: 400
        height: 400
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 50
        columns: 3
        rows: 3
        spacing: (width-ptWidth*3)/2

        LockPoint{width:ptWidth; lockId: 1;}
        LockPoint{width:ptWidth; lockId: 2;}
        LockPoint{width:ptWidth; lockId: 3;}
        LockPoint{width:ptWidth; lockId: 4;}
        LockPoint{width:ptWidth; lockId: 5;}
        LockPoint{width:ptWidth; lockId: 6;}
        LockPoint{width:ptWidth; lockId: 7;}
        LockPoint{width:ptWidth; lockId: 8;}
        LockPoint{width:ptWidth; lockId: 9;}
    }


    //----------------------------------
    // 绘制圆点和连线
    //----------------------------------
    Canvas{
        id: canvas
        anchors.fill: grid
        opacity: 0.6
        MouseArea{
            id: area
            anchors.fill: parent
            onPressed: checkAndDraw();
            onPositionChanged: checkAndDraw();
            // 检测并绘制
            function checkAndDraw(){
                if(area.pressed) {
                    root.checkLockPoints();
                    canvas.requestPaint();
                }
            }
        }


        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            drawPasswordGraphy(ctx);
        }

        // 绘制密码图
        function drawPasswordGraphy(ctx){
            var lastPt = null;
            for (var i=0; i<lockPoints.length; i++){
                var currPt = lockPoints[i];
                drawRound(ctx, currPt.center, 30, 'yellow');
                if (lastPt != null)
                    drawLine(ctx, lastPt.center, currPt.center, ptLineWidth, 'yellow');
                lastPt = currPt;
            }
        }

        // 绘制圆点
        function drawRound(ctx, pt, r, c){
            ctx.beginPath();
            ctx.arc(pt.x, pt.y, r, 0, 2*Math.PI);
            ctx.fillStyle = c;
            ctx.fill();
        }

        // 绘制线段
        function drawLine(ctx, p1, p2, w, c){
            ctx.beginPath();
            ctx.moveTo(p1.x, p1.y);
            ctx.lineTo(p2.x, p2.y);
            ctx.lineWidth = w;
            ctx.strokeStyle = c;
            ctx.stroke();
        }
    }


}

