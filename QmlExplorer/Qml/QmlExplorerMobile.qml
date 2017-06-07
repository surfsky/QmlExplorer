import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtWebKit 3.0
import "./js/ajax.js" as Ajax
import "./Controls/Views/FolderListView"
//import "./Controls/DataView/Model/"

/**
Qml运行器（移动版本），可以展示qml源码
    /输出url，可显示源码、web、qml
    /Qml
       /进度条（这个不好弄，没这个接口）
       错误页面用text展示吧
    /左侧本地文件菜单
    /folder逻辑
    /Web/进度条
    /代码高亮代码编辑器
    按钮
        open
        前进返回按钮
    移动版本美化
        列表》内容（参考stock示例）
        全屏
        工具栏可隐藏
    公共属性组件：
        property Description desc: Description{
            title:
            info:
        }
    控制台输出窗口
    qml页面结构输出窗口
*/
Item
{
    // basic
    id: root
    width: 800
    height: 600


    //-----------------------------------------------
    // 公共属性
    //-----------------------------------------------
    property alias url : txtUrl.text;

    //-----------------------------------------------
    // 私有方法
    //-----------------------------------------------
    // 显示指定URL的内容（源码、web、qml）
    // 兼容 file:///d:/coding-qt/_code/_test/QtMobile/QtMobile/Qml/UI/DataView/TableView/TestTableView.qml
    function show(url){
        lblStatus.text = "0%";
        console.debug(url);
        Ajax.get(
            txtUrl.text,
            function(result){
                containerText.text = result;
                lblStatus.text = "100%";
                showPanel(0);
            }, function(result, info){
                containerText.text = result;
                lblStatus.text = "100%";
                showPanel(0);
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
            showQml(containerText.text, url);
        else if (id == 1)
            containerWeb.loadHtml(containerText.text, url, url);
    }


    // 显示qml。folder为该qml组件创建时分配的目录，用于其相对路径资源引用
    function showQml(sourceCode, filepath)
    {
        lblStatus.text = "0%"
        clearChildren(containerQml);
        try{
            var obj = Qt.createQmlObject(sourceCode, containerQml, filepath);
        }catch(e){
            showQmlFail(e.message);
        }
        lblStatus.text = "100%"
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
               item.children[i].destroy();
    }

    // 显隐目录面板
    function switchFolderPanel()
    {
        if (navigator.x < 0)
            navigator.x = 0;
        else
            navigator.x = -navigator.width;
    }


    //-----------------------------------------------
    // 顶部工具栏
    //-----------------------------------------------
    Rectangle {
        id: titleBar
        anchors.top: root.top
        anchors.left: root.left
        anchors.right: root.right
        height: 30

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#f0f0f0" }
            GradientStop { position: 1.0; color: "#e0e0e0" }
        }

        Button{
            id: btnFolder
            x: 10
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            text: "Folder"
            onClicked: switchFolderPanel();
        }

        TextField{
            id: txtUrl
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: btnFolder.right
            anchors.right: btnGo.left
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            text: "http://www.baidu.com/"
        }

        Button{
            id: btnGo
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            text: "Go"
            onClicked: show(txtUrl.text)
        }
    }


    //-----------------------------------------------
    // 主界面
    //-----------------------------------------------
    Rectangle{
        id: main
        anchors.top: titleBar.bottom
        anchors.bottom: root.bottom
        anchors.left: root.left
        anchors.right: root.right

        // 本地文件导航器
        Rectangle{
            id: navigator
            x: 0;
            width: 200
            height: parent.height
            clip: true
            FolderListView{
                anchors.fill: parent
                fontSize: 12
                rowHeight: 20
                initFolder: '..'
                rootFolder: '../../'
                onItemClicked: {
                    if (!item.isDir){
                        txtUrl.text = item.url;
                        show(item.url);
                    }
                }
            }
            Behavior on x {
                PropertyAnimation{easing.type: Easing.OutExpo}
            }
        }

        // 内容展示区
        Rectangle{
            height: parent.height
            anchors.left: navigator.right
            anchors.right: parent.right

            //-----------------------------------------------
            // 内容区
            //-----------------------------------------------
            Rectangle{
                id: containerMain
                y:0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: tabView.top

                // 3个视图
                Item{
                    id: containerQml
                    anchors.fill: parent
                    visible: false
                    clip: true
                }
                WebView {
                    id: containerWeb
                    anchors.fill: parent
                    visible: false
                    onLoadProgressChanged: lblStatus.text = loadProgress + '%'
                }
                QmlEditor{
                    id: containerText
                    anchors.fill: parent
                    visible: false
                }
                // 错误组件视图
                Component{
                    id: failComponent
                    TextArea{
                        anchors.fill: parent
                        font.pixelSize: 12
                        wrapMode: TextEdit.NoWrap
                    }
                }
            }

            //-----------------------------------------------
            // tabview 当切换按钮用
            //-----------------------------------------------
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
                    showPanel(currentIndex);
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


    }





}
