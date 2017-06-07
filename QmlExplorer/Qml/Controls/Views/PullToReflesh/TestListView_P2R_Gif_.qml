import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2


/**
下拉刷新和上拉分页逻辑
    /下拉刷新（用gif动画）
    /上拉分页
BUG
    LOADING状态无效
    无法撤销刷新
*/
Rectangle {
    id: root;
    width: 320;
    height: 480;

    property bool needReflesh : false;
    property bool needLoadMore : false;


    //-----------------------------------------
    // listview
    //-----------------------------------------
    ListView {
        id: lv;
        z: 1;
        anchors.fill: parent;
        focus: true;
        activeFocusOnTab: true;

        // 定位到第一个元素（不显示header）
        Component.onCompleted: contentY=0;

        // 数据和显示
        model: dynamicModel;
        delegate: listDelegate;
        highlight: Rectangle {
            color: "steelblue";
            opacity: 0.5
        }

        // 下拉刷新和上拉分页逻辑
        property real startY: 0;
        onMovementEnded: {
            console.log("movementEnded: originY:" + originY + ", contentY:" + contentY);
            // 刷新
            if (root.needReflesh){
                dynamicModel.reflesh();
                root.needReflesh = false;
            }
            // 加载新数据
            if (root.needLoadMore){
                dynamicModel.loadMore();
                root.needLoadMore = false;
            }

            // 拖动过小自动隐藏
            if (contentY<0 && -contentY <= lv.headerItem.height)
                contentY = 0;
        }
        onContentYChanged: {
            // 下拉刷新判断逻辑：已经到头了，还下拉一定距离
            if (contentY < originY){
                var dy = contentY - originY;             // 距离（下拉时是负值）
                var max = -20;                           // 临界距离（启动刷新）
                var cnt = headerItem.totalFrame;         // 动画总帧数
                var step = -max/cnt;                     // 每帧需要移动的距离
                var n = Math.min(Math.round(-dy/step), cnt-1); // 当前第几帧

                console.log("y: " + contentY + ", dy: " + dy + ", " + n + "/" + (cnt-1));
                headerItem.currentFrame = n;
                if (dy < max){
                    needReflesh = true;
                }
            }
            // 上拉加载判断逻辑：已经到底了，还上拉一定距离
            if (contentHeight>height && contentY-originY > contentHeight-height){
                var dy = (contentY-originY) - (contentHeight-height);
                console.log("y: " + contentY + ", dy: " + dy);
                if (dy > 40){
                    needLoadMore = true;
                }
            }
        }

        // 下拉刷新区域
        header : Item{
            width: parent.width
            height: gif.height
            property alias gifHeight: gif.height
            property alias currentFrame : gif.currentFrame
            property alias totalFrame : gif.frameCount
            property bool busy : false;
            onBusyChanged: {
                busyIndicator.running = busy;  //// 无效
                gif.visible = !busy;
                console.log('busy: ' + busy);
            }

            AnimatedImage {
                id: gif;
                source: "./images/apple2.gif"
                playing: false
                anchors.centerIn: parent
                visible: true
            }
            // busy
            BusyIndicator{
                id: busyIndicator
                anchors.centerIn: parent
                running: false;
            }
        }

        // 动画
        Behavior on contentY{
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
        // 模型修改后停止加载动画
        onModelChanged: {
            if (lv.headerItem != null){
                lv.headerItem.busy = false;
                console.log('model changed')
            }
        }
    }

    //-----------------------------------------
    // model
    //-----------------------------------------
    ListModel{
        id: dynamicModel;
        Component.onCompleted: reflesh();
        function reflesh(){
            console.log("reflesh");
            dynamicModel.clear();
            appendData(20, 0);
            lv.contentY = 0;
            lv.onModelChanged();
        }
        function loadMore(){
            console.log("more");
            var n = dynamicModel.count;
            appendData(n, n);
            lv.onModelChanged();
        }
        function appendData(n, initCnt){
            lv.headerItem.busy = true;
            for (var i = 0 ; i < n ; ++i) {
                append({"index": i+initCnt, "content": "Item " + (i + initCnt)})
            }
        }
    }

    //-----------------------------------------
    // delegate
    //-----------------------------------------
    Component {
        id: listDelegate;
        Text {
            id: wrapper;
            width: parent.width;
            height: 32;
            font.pointSize: 15;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignHCenter;
            text: content;
            color: ListView.view.currentIndex == index ? "white" : "#505050";
            MouseArea {
                anchors.fill: parent;
                onClicked:  wrapper.ListView.view.currentIndex = index;
            }
        }
    }
}
