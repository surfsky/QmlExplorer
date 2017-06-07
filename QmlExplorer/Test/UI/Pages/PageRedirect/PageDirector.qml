import QtQuick 2.2
import QtQuick.Controls 1.1


/**
导演页面
    /各页面继承自Page基类，并用redirect()事件进行跳转
    /集中处理页面跳转逻辑
    /可以确保释放动态加载的页面资源
    /含loading效果
    /含back键处理
*/
Rectangle {
    id: root
    width: 800
    height: 600

    // 公共属性
    property string initPage : "Page1.qml"   // 初始页面
    property var pages : [];                 // 历史页面


    // 页面加载器
    Loader{
        id: loader
        anchors.fill: parent
        source: initPage
        onLoaded: busyIndicator.running = false;
        focus: true
    }
    BusyIndicator{
        id: busyIndicator
        running: false
        anchors.centerIn: parent
    }

    // 消息处理器(redirect, back)
    Connections{
        target: loader.item
        onRedirect: {
            if (url != null){
                pages.push(loader.source);  // 跳转前的url压入堆栈
                console.log(pages);
                busyIndicator.running = true;
                loader.source = url;
            }
        }
        onBack:{
            if (pages.length > 0){
                var url = pages.pop();
                console.log(pages);
                busyIndicator.running = true;
                loader.source = url;
            }
        }
    }
}
