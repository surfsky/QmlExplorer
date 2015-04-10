import QtQuick 2.0
import "../../../js/color.js" as ColorHelper
import "../../../js/common.js" as Common

/**
色带色彩选择器
    HSB色域
    点击设置色彩
    也可考虑用repeater结合rectangle来实现，需比较测试性能
调用
    ColorBandPicker{
        color: 'green'
        pieces: 90;
    }
备注
    加上light的渐变，可做成ColorGridPicker
协议：MIT. 请保留本协议说明
作者: surfsky.cnblogs.com 2015-01
*/
Canvas {
    id: root
    width: 360;
    height: 80

    property color color : 'green';
    onWidthChanged: {requestPaint();}
    Component.onCompleted: {requestPaint();}
    onColorChanged: {requestPaint();}


    //--------------------------------------
    // 私有属性
    //--------------------------------------
    property int ptX : setPosition(color); // 点位置
    property int ptRadius : 4;             // 点半径
    property int pieces : 90;              // 分成多少段


    //--------------------------------------
    // 色彩和色块的位置处理
    //--------------------------------------
    function getColor(x){
        var dw = width/pieces;    // 每片的宽度
        var n = Math.round(x/dw); // 当前第几片
        var dh = 1/pieces;        // 每片色相变化值
        var h = dh*n;             // 当前色相值
        //console.log('n=' + n + ', h=' + h);
        return Qt.hsla(h, 1.0, 0.5, 1.0);
    }
    function setPosition(c){
        var dw = width/pieces;    // 每片的宽度
        var hsl = ColorHelper.rgbToHsl(c.r, c.g, c.b);
        var x = (Math.round(hsl.h*pieces)+0.5)*dw;
        Common.log('(%f, %f, %f), (%f, %f, %f), x=%d', c.r, c.g, c.b, hsl.h, hsl.s, hsl.l, x);
        return x;
    }


    //--------------------------------------
    // 绘制色彩条带和当前选择色彩点
    //--------------------------------------
    onPaint: {
        var ctx = getContext("2d")

        // 画渐变色带
        var dw = width/pieces;   // 每段的宽度
        for (var i=0; i<=pieces; i++){
            var c = Qt.hsla(i/pieces, 1.0, 0.5, 1.0);
            var x = dw*i;
            //console.log('i=' + i + ', dw=' + dw + ', x=' + x + ", c=" + c);
            ctx.fillStyle = c;
            ctx.fillRect(x, 0, dw, height);
        }

        // 画圆
        ctx.beginPath();
        ctx.arc(ptX, height/2, ptRadius, 0, Math.PI * 2, true);
        ctx.closePath();
        ctx.lineWidth = 2;
        ctx.strokeStyle = 'white';
        ctx.stroke();
    }

    // 用户交互设置色彩
    MouseArea{
        anchors.fill: parent
        onPressed:{color = getColor(mouse.x);}
        onPositionChanged: {if (pressed) color=getColor(mouse.x);}
    }
}

