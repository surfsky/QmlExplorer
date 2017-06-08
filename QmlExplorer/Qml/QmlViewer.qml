import QtQuick 2.0
import QtQuick.Controls 1.2
import QtWebView 1.1
import "./Js/ajax.js" as Ajax

/**
QML 文件查看器
包括qml、web、source、debug四个面板
**/
Item{
    id: root
    width: 500
    height: 800

    property string url : "file:///d:/coding-qt/_code/_test/QmlExplorer/QmlExplorer/Qml/Common/TestColor.qml";
    property Item container: containerQml;  // qml展示容器
    signal loaded;                          // qml加载完毕


    //-----------------------------------------------
    // 私有方法
    //-----------------------------------------------
    // 显示指定URL的内容（源码、web、qml）
    function show(url){
        root.url = url;
        console.log('url: ' + url);
        lblStatus.text = "0%";
        Ajax.get(
            txtUrl.text,
            function(result){
                containerText.text = result;
                lblStatus.text = "100%";
                showPanel(0);
                loaded();
            }, function(result, info){
                containerText.text = result;
                lblStatus.text = "100%";
                showPanel(0);
                loaded();
            }
        );
    }


    // 显示指定面板
    // qml 和 web 都是依赖 text创建的
    // 修改text后再点击qml页面可以查看效果
    function showPanel(id)
    {
        tabView.currentIndex = id;
        containerQml.visible = (id == 0);
        containerWeb.visible = (id == 1);
        containerText.visible = (id == 2);
        if (id == 0)
            root.showQml(containerText.text, url);
        else if (id == 1)
            containerWeb.loadHtml(containerText.text, url, url);
    }


    // 显示qml。filePath为该qml组件创建时分配的目录文件名，用于其相对路径资源引用
    function showQml(sourceCode, filepath)
    {
        lblStatus.text = "0%"
        clearChildren(containerQml);
        containerQml.update();  // 马上刷新，强制立即清除子控件
        try{
            var obj = Qt.createQmlObject(sourceCode, containerQml, filepath);
        }catch(e){
            showQmlFail(e.message);
        }
        lblStatus.text = "100%"
        //panInsight.showDetail();
    }

    // 显示错误信息
    function showQmlFail(info){
        clearChildren(containerQml);
        var obj = failComponent.createObject(containerQml, {text: info});
    }

    // 清空子节点
    function clearChildren(item)
    {
        for (var i = 0; i < item.children.length; i++)
            if (item.children[i].destory != 'undifined')
               item.children[i].destroy(0);
    }


    //-----------------------------------------------
    // UI
    //-----------------------------------------------
    // 内容区
    Rectangle{
        id: containerMain
        y:0
        anchors.fill: parent
        anchors.bottomMargin: tabView.height

        // Qml视图
        Item{
            id: containerQml
            anchors.fill: parent
            visible: false
            clip: true
        }
        // Web视图
        WebView {
            id: containerWeb
            anchors.fill: parent
            visible: false
            onLoadProgressChanged: lblStatus.text = loadProgress + '%'
        }
        // 源码视图
        /*
        TextArea{
            id: containerText
            anchors.fill: parent
            visible: true
            wrapMode: TextEdit.NoWrap
        }
        */
        // 语法高亮编辑器视图
        QmlEditor{
            id: containerText
            anchors.fill: parent
            visible: false
        }
        // 错误视图
        Component{
            id: failComponent
            TextArea{
                anchors.fill: parent
                font.pixelSize: 12
                wrapMode: TextEdit.NoWrap
            }
        }
    }

    // tabview（当切换按钮用）
    TabView {
        id: tabView
        height: 20
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        tabPosition: Qt.BottomEdge
        Tab {title: "Qml"}
        Tab {title: "Web"}
        Tab {title: "Source"}
        onCurrentIndexChanged: {
            root.showPanel(currentIndex);
        }
        Text{
            id: lblStatus
            anchors.right: parent.right
            anchors.rightMargin: 10
            y: 5
            width: 50
        }
    }
}
