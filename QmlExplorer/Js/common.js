//--------------------------------
// 引用其它js文件
//--------------------------------
Qt.include("string.js");
Qt.include("math.js");
Qt.include("date.js");
Qt.include("ajax.js");
Qt.include("json.js");
Qt.include("array.js");
Qt.include("qml.js");



// 某个点是否在指定区域内
function isInRect(p, rect){
    return  p.x >= rect.x
         && p.x <= rect.x+rect.width
         && p.y >= rect.y
         && p.y <= rect.y+rect.height
}


/*
C语言风格格式化字符串输出
格式
    "%" [索引 ":"] ["-"] [宽度] ["." 摘要] 类型
eg
    Common.log('%06d', 10);      // 000010
    Common.log('% 6d', 10);      //     10
    Common.log('% 6s', 'he');    //     he
    Common.log('%06f', 10.3);    // 0010.3
    Common.log('%06.3f', 10.3);  // fail
    Common.log('%-6.3f', 10.3);  // fail
Q: 如何合并这两个函数？
*/
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


function sprintf(){
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
    return txt;
}


