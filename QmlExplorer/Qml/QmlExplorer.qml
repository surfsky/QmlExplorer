import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import "./Controls/Views/FolderListView"

/**
Qml运行器，可以展示qml源码
    /输出url，可显示源码、web、qml
    /Qml
       /进度条（这个不好弄，没这个接口）
       错误页面用text展示吧
    /左侧本地文件菜单
    /folder逻辑
    /Web/进度条
    /代码高亮代码编辑器


Insight 面板
    /显示控件层次
    BUG: 删除不干净
    显示qml组件属性

控制台输出组件
    控制台输出重定向
    控制台输出面板

辅助
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

docker面板
    工具栏可收缩成一个标签（docker）

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


    // 显示指定URL的QML文件
    function show(url)
    {
        panMain.show(url);
    }

    //-----------------------------------------------
    // 私有方法
    //-----------------------------------------------
    // 显隐目录面板
    function switchFolderPanel()
    {
        panNavigator.width = panNavigator.width > 0 ? 0 : root.width/4;
    }

    // 显隐Insight面板
    function switchInsightPanel()
    {
        panInsight.width = panInsight.width > 0 ? 0 : root.width/4;
        main.update();
        //panInsight.x = (panInsight.x < root.width) ? root.width : root.width-panInsight.width;
    }



    //-----------------------------------------------
    // 顶部工具栏
    //-----------------------------------------------
    Rectangle{
        id: titleBar
        height: 30
        width: parent.width;
        LinearGradient {
            anchors.fill: parent
            gradient: Gradient{
                GradientStop { position: 0.0; color: "#f0f0f0" }
                GradientStop { position: 1.0; color: "#e0e0e0" }
            }
        }

        Button{
            id: btnFolder
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            text: "Folder"
            onClicked: switchFolderPanel();
        }
        Button{
            id: btnInsight
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: btnFolder.right;
            anchors.leftMargin: 5;
            text: "Insight"
            onClicked: switchInsightPanel();
            visible: false; // 这个按钮有bug
        }
        TextField{
            id: txtUrl
            anchors.verticalCenter: parent.verticalCenter
            text: "http://www.baidu.com/"
            anchors.left: btnFolder.right;
            anchors.leftMargin: 5;
            anchors.right: btnGo.left;
            anchors.rightMargin: 5;
        }
        Button{
            id: btnGo
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right;
            anchors.rightMargin: 5
            text: "Go"
            onClicked: show(txtUrl.text)
        }
    }



    //-----------------------------------------------
    // 主界面
    //-----------------------------------------------
    SplitView{
        id: main
        anchors.fill: parent
        anchors.topMargin: titleBar.height

        // 本地文件导航器面板
        FolderListView{
            id: panNavigator
            width: parent.width/4
            height: parent.height
            fontSize: 12
            rowHeight: 20
            initFolder: Qt.resolvedUrl('.')
            rootFolder: Qt.resolvedUrl('../../')
            onItemClicked: {
                if (!item.isDir){
                    txtUrl.text = item.url;
                    show(item.url);
                }
            }
            Behavior on width {
                PropertyAnimation{easing.type: Easing.OutExpo}
            }
        }

        // 内容展示面板
        QmlViewer{
            id: panMain
            width: parent.width/2
            height: parent.height
            onLoaded: panInsight.show(this.container);
        }

        // Insight 面板（Qml结构展示）
        QmlInsighter{
            id: panInsight
            width: parent.width/4
            height: parent.height
            clip: true
        }
    }
}
