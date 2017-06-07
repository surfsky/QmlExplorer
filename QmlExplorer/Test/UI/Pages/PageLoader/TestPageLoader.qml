import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import "../../../controls/BusyIndicator/"



/*
用Loader动态加载qml页面
    /含遮罩层，禁止重复操作
    /启用indicator加载动画
    /含时延处理
*/
Rectangle{
    id: root
    height:480
    width:320

    // 首次加载page1
    Component.onCompleted: go("../Page1.qml")

    //
    function go(url)
    {
        //loader.source = url;
        busyIndicator.start(url);
    }


    //----------------------------------
    // items
    //----------------------------------
    Row
    {
        width: parent.width
        height: 40
        spacing: 10
        ToolButton {
            text: 'page1'
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            onClicked: go("../Page1.qml");
        }
        ToolButton {
            text: 'page2'
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            onClicked: go("../Page2.qml");
        }
        ToolButton {
            text: 'page3'
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            onClicked: go("../Page3.qml");
        }
        ToolButton {
            text: 'quit'
            width: 60
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {Qt.quit();}
        }
        Text{
            id: txtInfo
            text : ''
            anchors.verticalCenter: parent.verticalCenter
        }
    }



    //----------------------------------
    // loader
    //----------------------------------
    // 加载器
    Loader{
        id:loader
        anchors.fill: parent
        anchors.topMargin: 50
        onLoaded: busyIndicator.stop();
    }

    // 繁忙指示器
    MaskBusyIndicator{
        id: busyIndicator
        visible: false
        anchors.fill: parent
        delay: 200
        timeout: 2000
        maskColor: '#44000000'
        onDelayFinished: loader.source = tag;
        onTimeoutChanged: console.log('time out');
    }
}


