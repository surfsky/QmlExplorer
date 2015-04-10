import QtQuick 2.0
import "../../js/ajax.js" as Ajax

/**
模拟XmlListModel 实现 JsonListModel
以ajax方式获取网络json数据，并根据指定的path获取列表数据
*/
ListModel{
    id: model
    property string source : 'http://wthrcdn.etouch.cn/weather_mini?city=%E5%8C%97%E4%BA%AC';
    property string path : '.data.forecast';
    property string method : 'GET'
    property string arg : ''

    property var    sourceData;    // 整个url获取的json对象
    property var    pathData;      // 路径对应的json对象

    signal loadStart();
    signal loadCompleted();
    signal loadFail(var error);

    Component.onCompleted: {
        console.info('loading');
        loadStart();
        Ajax.ajax(source, method, arg,
             function(result, json){
                sourceData = json;
                pathData = eval("json" + path);  /////
                model.append(pathData);   // 如果是个字符串数组，这样append会有问题
                loadCompleted();
            },
            function(result, json){
                console.log(result);
                loadFail(result);
            }
         );
    }
}
