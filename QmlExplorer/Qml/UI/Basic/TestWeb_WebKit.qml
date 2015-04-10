import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtWebKit 3.0

/**
qt 5.3（含） 以前用webkit来实现webview
qt 5.4以后将逐渐废除该组件，用：
    - 通用的 WebEngine: 桌面平台
    - 原生的 WebView： 移动平台 android、ios
*/
ColumnLayout {
    id: root
    width: 640
    height: 480

    // 工具栏
    Rectangle{
        height: 40
        color: 'lightgrey'
        Layout.fillWidth: true

        TextField{
            id: edtUrl
            text: 'http://baidu.com'
            anchors.left: parent.left
            anchors.right: btnGo.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
        }
        Button{
            id: btnGo
            width: 60
            anchors.right: parent.right
            anchors.rightMargin: 5
            text: 'go'
            anchors.verticalCenter: parent.verticalCenter
            onClicked:{
                var url = edtUrl.text;
                console.log(url);
                webView.url = url;
            }
        }
    }

    // webview(base webkit)
    WebView {
        id: webView
        url: "http://www.nokia.com"
        Layout.fillHeight: true
        Layout.fillWidth: true
        scale: 1.0
        smooth: false
        onNavigationRequested: {
            // 链接处理，在此可屏蔽外网链接
            var schemaRE = /^\w+:/;
            if (schemaRE.test(request.url)) {
                request.action = WebView.AcceptRequest;
            } else {
                request.action = WebView.IgnoreRequest;
            }
        }
    }
}
