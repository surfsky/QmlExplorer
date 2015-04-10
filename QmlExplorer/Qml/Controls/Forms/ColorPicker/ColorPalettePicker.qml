import QtQuick 2.0

/**
调色板色块选择器
    /用户自定义调色板，二维调色板数组
    /自动生成的调色板，基于hsl色彩空间
        /饱和度为1，亮度变化
        亮度固定0.5，饱和度变化
    /可设置颜色值，会在匹配的调色板色块上显示标志
    自动生成的调色板，如何融合不透明度

使用
    // 定义一个调色板色彩选择器，色彩自定义
    ColorPalettePicker{
        color: 'red'
        palette: [['red', 'green', 'black']]
    }
    // 创建一个调色板，调色板自动生成
    ColorPalettePicker{
        paletteSize : Qt.size(90, 10)
    }

思路
    /内部维护一个调色板二维数组和当前色块位置
    /onPaint 事件将该数组绘制出来
    可依赖本模块定制任意的取色器
        附加黑色块、白色块、透明色

协议：MIT. 请保留本协议说明
历史：初版 2015-01-07 surfsky.cnblogs.com
*/
Canvas {
    id: root
    width: 360;
    height: 80

    //--------------------------------------
    // 公共属性
    //--------------------------------------
    signal exited;
    property int ptRadius : 4;               // 点半径

    // 色彩值
    property color color : '#ff0000';        // 色彩值
    property var hsl : rgbToHsl(color.r, color.g, color.b);
    onColorChanged: {
        if (!area.pressed)
            currentBlock = getMatchBlock(color);
        requestPaint();
    }

    // 调色板（二维数组 palette[x][y]）
    property var palette : [
        ['red',     'green',    'black'],
        ['#00ff00', '#999900',  '#ff00ff']
        ];
    onPaletteChanged: {requestPaint();}


    // 自动绘制调色板
    property size paletteSize : Qt.size(90, 10);
    onPaletteSizeChanged: {
        if (paletteSize == Qt.size(0,0)) return;
        setPalleteBySize(paletteSize.width, paletteSize.height);
    }


    // 尺寸变更重绘
    onHeightChanged: {requestPaint();}
    onWidthChanged: {requestPaint();}


    //--------------------------------------
    // 私有属性
    //--------------------------------------
    property int cx : palette.length;      // 横向色块个数
    property int cy : palette[0].length;   // 纵向色块个数
    property real dw : width/cx;           // 色块宽度
    property real dh : height/cy;          // 色块高度
    property point currentBlock : Qt.point(-1, -1); // 当前色块位置


    //--------------------------------------
    // 绘制色彩条带和当前选择色彩点
    //--------------------------------------
    onPaint: {
        cx = palette.length;
        cy = palette[0].length;
        dw = width/cx;
        dh = height/cy;
        var ctx = getContext("2d")
        drawPalette(ctx);
        drawPoint(ctx);
    }

    // 用户交互设置色彩
    MouseArea{
        id: area
        anchors.fill: parent
        onPressed:         {clickBlock(mouseX, mouseY);}
        onPositionChanged: {if (pressed) clickBlock(mouseX, mouseY);}
        function clickBlock(x, y){
            var bx = Math.min(palette.length-1, Math.floor(x/dw));    // 横向第几块
            var by = Math.min(palette[0].length-1, Math.floor(y/dh)); // 纵向第几块
            root.currentBlock = Qt.point(bx, by);
            root.color = palette[currentBlock.x][currentBlock.y];
            var hsl = rgbToHsl(color.r, color.g, color.b);
            logColor(color, hsl, Qt.point(x, y), currentBlock);
        }
        onExited: root.exited();
    }

    //--------------------------------------
    // 色彩和位置互转
    //--------------------------------------
    // 找最近似的色块
    property color _c1;
    property color _c2;
    function getMatchBlock(c){
        log('set color: %s(%s)', c, typeof c);
        for (var x=0; x<cx; x++){
            for (var y=0; y<cy; y++){
                if (colorEqual(c, palette[x][y])){
                    log('match: (%d,%d)', x, y);
                    return Qt.point(x, y);
                }
            }
        }
        log('match none');
        return Qt.point(-1, -1);
    }
    // 色彩值比较(c1, c2 很可能是字符串，这就是弱类型语言的麻烦点）
    function colorEqual(c1, c2){
        _c1 = c1; // 如何将字符串转化为color对象?
        _c2 = c2;
        return (_c1.toString() == _c2.toString());
        //return Qt.colorEqual(c1, c2);  // Qt的这个方法有bug
    }

    // 绘制调色板（根据调色板数组）
    function drawPalette(ctx){
        for (var x=0; x<cx; x++){
            for (var y=0; y<cy; y++){
                var c = palette[x][y];
                ctx.fillStyle = c;
                ctx.fillRect(dw*x, dh*y, dw, dh);
            }
        }
    }

    // 绘制当前色点（根据当前色块位置）
    function drawPoint(ctx){
        if (currentBlock.x == -1)
            return;
        var block = currentBlock;
        var pt = Qt.point((block.x+0.5)*dw, (block.y+0.5)*dh);
        ctx.beginPath();
        ctx.arc(pt.x, pt.y, ptRadius, 0, Math.PI * 2, true);
        ctx.closePath();
        ctx.lineWidth = 2;
        ctx.strokeStyle = colorEqual(palette[block.x][block.y], 'white') ? 'black' : 'white';
        ctx.stroke();
    }

    // 根据尺寸自动设置调色板
    function setPalleteBySize(w, h){
        palette = [];
        // 黑白双色调色板
        if (w == 2 && h == 1){
            palette = [['#000000'], ['#ffffff']];
        }
        else if (w == 1 && h == 2){
            palette = [['#000000', '#ffffff']];
        }

        // 黑白金银调色板
        else if (w == 2 && h == 2){
            palette = [['#000000', '#ffffff'], ['#f0f0f0', 'gold']];
        }

        // 横向单行固定亮度调色板
        else if (w > 2 && h == 1){
            for (var x=0; x<w; x++) {
                palette[x] = [];
                for (var y=0; y<h; y++){
                    palette[x][y] = Qt.hsla(x/w, 1, 0.5, 1.0);
                }
            }
        }
        // 纵向单列灰度调色板
        else if (w == 1 && h > 2){
            for (var x=0; x<w; x++){
                palette[x] = [];
                for (var y=0; y<h; y++){
                    palette[x][y] = Qt.hsla(0.5, 0, y/h, 1.0);
                }
            }
        }
        // 二维色相亮度调色板
        else{
            for (var x=0; x<w; x++){
                palette[x] = [];
                for (var y=0; y<h; y++){
                    palette[x][y] = Qt.hsla(x/w, 1, y/h, 1.0);
                }
            }
        }
        log("init palette : (%d,%d)", w, h);
    }

    //--------------------------------------
    // 辅助方法
    //--------------------------------------
    // RGB色彩转化为HSL色彩
    function rgbToHsl(r, g, b){
        var max = Math.max(r, g, b);
        var min = Math.min(r, g, b);
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

