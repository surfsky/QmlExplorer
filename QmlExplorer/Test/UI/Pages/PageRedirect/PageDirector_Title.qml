import QtQuick 2.2
import QtQuick.Controls 1.1


// 多页面切换方案
// - 用loader动态加载page
// - 用connections处理自定义事件
Rectangle {
    id: root
    width: 640
    height: 480

    // title
    Rectangle {
        id: titleBlock
        anchors.left: parent.left;
        anchors.right: parent.right;
        color: 'lightblue'
        height: 20
        Text{
            id: titleText
            text: 'title'
            color: 'white'
            font.bold: true
            anchors.verticalCenter: titleBlock.verticalCenter
            anchors.horizontalCenter: titleBlock.horizontalCenter
        }
        BusyIndicator{
            id: busyIndicator
            running: false
            anchors.right: titleBlock.right
            anchors.rightMargin: 10
        }
    }

    // loader
    Loader{
        id: loader
        anchors.fill: parent
        anchors.topMargin: 20
        source: 'Page1.qml'
        height: 20;
        width: 20;
        onLoaded: {
            busyIndicator.running = false;
            root.title = item.title;
        }
    }

    // handler loader item's 'redirect' event
    Connections{
        target: loader.item
        onRedirect: {
            if (url != null){
                root.url = url;
                busyIndicator.running = true;
                timer.running = true;
            }
        }
    }

    // 加上延时效果。可考虑完全用js创建，并用connect语法处理trigger事件
    Timer{
        id: timer
        interval: 500
        running: false
        repeat: false
        onTriggered: setUrl();
    }

    property string url;
    property string title;
    function setUrl(){
        loader.source = url;
        if (title != null)
            titleText.text = title
    }
}
