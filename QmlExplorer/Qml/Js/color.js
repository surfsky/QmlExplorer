/*
色彩处理相关辅助方法
http://stackoverflow.com/questions/2353211/hsl-to-rgb-color-conversion
*/

// 获取对比色（便于文字显示）
function getAntiColor(color){
    return Qt.rgba(1-color.r, 1-color.g, 1-color.b, 1);
}

/**
 * Converts an HSL color value to RGB. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSL_color_space.
 * @param   Number  h       The hue(0-1)
 * @param   Number  s       The saturation(0-1)
 * @param   Number  l       The lightness(0-1)
 * @return  Array           The RGB representation [r, g, b]
 */
function hslToRgb(h, s, l){
    var r, g, b;
    if(s == 0){
        r = g = b = l; // achromatic
    }else{
        function hue2rgb(p, q, t){
            if(t < 0) t += 1;
            if(t > 1) t -= 1;
            if(t < 1/6) return p + (q - p) * 6 * t;
            if(t < 1/2) return q;
            if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
            return p;
        }

        var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
        var p = 2 * l - q;
        r = hue2rgb(p, q, h + 1/3);
        g = hue2rgb(p, q, h);
        b = hue2rgb(p, q, h - 1/3);
    }

    return {r:r, g:g, b:b};
}



/**
 * Converts an RGB color value to HSL. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSL_color_space.
 * @param   Number  r       The red color value(0-1)
 * @param   Number  g       The green color value(0-1)
 * @param   Number  b       The blue color value(0-1)
 * @return  Array           The HSL representation [h,s,l]
 */
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
