/**
QML “includes” a JSON parser.
You can just use, without having to include anything:
*/

// json对象转化为字符串
// 注意，不能命名为toString，会冲突
function toStr(json) {
    return JSON.stringify(json);
}

// 用递归输出json text（有问题的，需要优化）
function toStr2(obj){
    var txt = '';
    for (var k in obj){
        if(typeof k === "object") {
            txt += toStr2(obj[x]);
        }
        else{
            txt += k + ":" + obj[x];
        }
        txt += ' ';
    }
    return txt;
}


// 字符串转化为json对象
function toJson(text){
    return JSON.parse(text);
}


// json对象转化为ListModel对象
function toListModel(json, parent){
    var model = Qt.createQmlObject('import QtQuick 2.2; ListModel{}', parent);
    model.append(json);
    return model;
}
