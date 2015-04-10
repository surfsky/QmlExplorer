import QtQuick 2.0
//import "../../../js/color.js" as ColorHelper
import "../../../js/common.js" as Common

/**
基于ColorBandPicker改造，加上Light维度
协议：MIT. 请保留本协议说明
作者: surfsky.cnblogs.com 2015-01


bug
    blocksX=1 的情况
    blocksY=1 的情况
    纯白色块
    纯黑色块
考虑维护一个数组，保存色块值，简化运算
*/
Canvas {
    id: root
    width: 360;
    height: 80

    // 公共属性
    property color color : 'green';          // 色彩值
    property int blocksX : 20;               // 宽度分成多少段
    property int blocksY : 10;               // 高度分成多少段
    onColorChanged: {requestPaint();}
    onWidthChanged: {requestPaint();}


    //--------------------------------------
    // 私有属性
    //--------------------------------------
    property point pt : getPosition(color);  // 点位置
    property int ptRadius : 4;               // 点半径


    //--------------------------------------
    // 绘制色彩条带和当前选择色彩点
    //--------------------------------------
    onPaint: {
        var ctx = getContext("2d")

        // 画渐变色带
        var dw = width/blocksX;    // 每段的宽度
        var dh = height/blocksY;   // 每片的高度
        for (var i=0; i<=blocksX; i++){
            for (var j=0; j<=blocksY; j++){
                var h = blocksX==1 ? 0.5 : i/blocksX;
                var l = blocksY==1 ? 0.5 : j/blocksY;
                var s = blocksX==1 ? 0   : 1;
                var c = Qt.hsla(h, s, l, 1.0);
                var x = dw*i;
                var y = dh*j;
                //console.log('i=' + i + ', dw=' + dw + ', x=' + x + ", c=" + c);
                ctx.fillStyle = c;
                ctx.fillRect(x, y, dw, dh);
            }
        }

        // 画圆
        ctx.beginPath();
        ctx.arc(pt.x, pt.y, ptRadius, 0, Math.PI * 2, true);
        ctx.closePath();
        ctx.lineWidth = 2;
        ctx.strokeStyle = 'white';
        ctx.stroke();
    }

    // 用户交互设置色彩
    MouseArea{
        anchors.fill: parent
        onPressed:{color = getColor(mouse.x, mouse.y);}
        onPositionChanged: {if (pressed) color=getColor(mouse.x, mouse.y);}
    }


    //--------------------------------------
    // 色彩和位置互转
    //--------------------------------------
    // 找到位置对应的色彩
    function getColor(x, y){
        /*
        var p = context.getImageData(x, y, 1, 1).data;
        var c = Qt.rgba(p[0], p[1], p[2], p[3]);
        console.log(c);
        return c;
        */
        var dw = width/blocksX;       // 每片的宽度
        var dh = height/blocksY;      // 每片的高度
        var bx = Math.floor(x/dw);    // 横向第几块
        var by = Math.floor(y/dh);    // 纵向第几块
        var hue = (1/blocksX)*bx;     // 色相值
        var light = (1/blocksY)*by;   // 亮度值
        //log("d=(%d,%d), pt=(%d,%d), block=(%d,%d)", dw, dh, x, y, bx, by);
        return Qt.hsla(hue, 1.0, light, 1.0);
    }

    // 找到色彩对应的色块中心点位置
    function getPosition(c){
        var dw = width/blocksX;             // 每片的宽度
        var dh = height/blocksY;            // 每片的高度
        var hsl = rgbToHsl(c.r, c.g, c.b);  // HSL色彩
        var bx = Math.round(hsl.h*blocksX); // 横向第几块
        var by = Math.round(hsl.l*blocksY); // 纵向第几块
        var x = (bx+0.5)*dw;                // 色块中心点X位置
        var y = (by+0.5)*dh;                // 色块中心点Y位置
        logColor(c, hsl, Qt.point(x, y), Qt.point(bx, by));
        return Qt.point(x, y);
    }

    //--------------------------------------
    // 辅助方法
    //--------------------------------------
    // RGB色彩转化为HSL色彩
    function rgbToHsl(r, g, b){
        var max = Math.max(r, g, b), min = Math.min(r, g, b);
        var h, s, l = (max + min) / 2;
        if(max == min){
            h = s = 0; // achromatic
        }else{
            var d = max - min;
            s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
            switch(max){
                case r: h = (g - b) / d + (g < b ? 6 : 0); break;
                case g: h = (b - r) / d + 2; break;
                case b: h = (r - g) / d + 4; break;
            }
            h /= 6;
        }
        return {h:h, s:s, l:l};
    }

    // 输出色彩值
    function logColor(rgb, hsl, pt, block){
        log('%s, hsl=(%f,%f,%f), rgb=(%f,%f,%f), pt=(%d,%d), block=(%d,%d)',
           rgb,
           round(hsl.h, 2),
           round(hsl.s, 2),
           round(hsl.l, 2),
           round(rgb.r, 2),
           round(rgb.g, 2),
           round(rgb.b, 2),
           pt.x,
           pt.y,
           block.x,
           block.y
           );
    }

    // 四舍五入到小数点某个位数
    function round(x, num){
        return Math.round(x * Math.pow(10, num)) / Math.pow(10, num) ;
    }

    // C语言风格格式化字符串
    function log(){
        var arg = [].slice.call(arguments)
        var fmt = arg.shift()
        var i = 0;
        var txt = fmt.replace(/%([\w| ])?(\d)?([dfscx])/ig, function(_,a,b,c){
            var s = b ? new Array(b-0+1).join(a||'') : '';
            if(c=='d') s += parseInt(arg[i]);
            if(c=='f') s += parseFloat(arg[i]);
            if(c=='s') s += arg[i];
            if(c=='c') s += arg[i];
            i++;
            return b ? s.slice(b*-1) : s;
        });
        console.log(txt);
    }
}

