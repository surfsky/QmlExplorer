import QtQuick 2.0

/**
日志记录器
    /显示到列表中
    /最大行数限制
    /可输出到console
    输出到文本文件
**/
ListView{
    id: root

    // 公共属性
    property int maxLines: 1000; // 最大日志行数
    property bool showInConsole: false; // 是否显示到控制台
    property string filePath;  // 保存文件名


    // 日志方法
    function info(category, info)     {log('info', category, info)}
    function warning(category, info)  {log('warning', category, info)}
    function alert(category, info)    {log('alert', category, info)}
    function log(level, category, info){
        if (model.count >= root.maxLines)
        {
            model.clear();
            //var cnt = root.maxLines/10;
            //if (cnt <= 1) cnt = model.count;
            //model.remove(0, cnt);
        }
        model.append({level:level, category:category, info:info});
    }

    // level->color
    function _getLevelColor(level){
        switch (level){
            case 'info':    return 'black';
            case 'warning': return 'blue';
            case 'alert':   return 'red';
            default:        return 'black';
            }
    }

    model: model
    delegate: Row{
        spacing: 5
        Text {text: index}
        Text {text: "[" + category + "]"; color: _getLevelColor(level)}
        Text {text: info; color: _getLevelColor(level)}
    }

    ListModel {
        id: model
        //ListElement {level:'info';    category: "Orange"; info:'normal';}
        //ListElement {level:'warning'; category: "Banana"; info:'warning';}
        //ListElement {level:'alert';   category: "Apple";  info:'alert';}
    }
}
