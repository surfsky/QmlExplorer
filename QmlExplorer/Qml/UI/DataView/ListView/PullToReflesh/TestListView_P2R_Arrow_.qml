import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2


/**
下拉刷新和上拉分页逻辑（用gif标志）
    /下拉刷新
    /上拉加载更多

封装成组件
    剥离出事件
    可设置下拉刷新图片

BUG:
    无法实现：下拉后上拉取消刷新
    loading效果（无效）
*/
Rectangle {
    id: root;
    width: 320;
    height: 480;


    property bool pressed: false;
    property bool needReflesh: false;
    property bool needLoadMore: false;


    //-----------------------------------------
    // listview
    //-----------------------------------------
    ListView {
        id: lv;
        z: 1;
        anchors.fill: parent;

        // 数据和显示
        model: vdm;
        //delegate: vdm.delegate;
        highlight: Rectangle {
            color: "steelblue";
            opacity: 0.5
        }

        // 下拉刷新区域
        header : Item{
            width: 130
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            AnimatedImage {
                id: imgHead;
                x: 7
                y: 1
                source: "./images/arrow-down-24.png"
                playing: true
                visible: true
            }
            Text{
                id: txt
                x: 54
                y: 2
                color: "#c0c0c0"
                text: '下拉可以刷新'
            }
            Text{
                id: txtDt
                x: 54
                y: 18
                color: "#c0c0c0"
                text: qsTr("Last Update:")
            }
            function goState(name){
                if (name == '')           {imgHead.source = './images/arrow-down-24.png'; txt.text='下拉可以刷新';}
                else if (name == 'ready') {imgHead.source = './images/arrow-up-24.png';   txt.text='放开即可刷新';}
                else if (name == 'load')  {imgHead.source = './images/loading-32.gif';    txt.text='加载中';}
                else if (name == 'ok')    {imgHead.source = './images/ok-24.png';         txt.text='下拉刷新'; txtDt.text=getDateString();}
            }
            function getDateString(){
                var dt = new Date();
                return dt.getHours() + ':'
                    + dt.getMinutes() + ":"
                    + dt.getSeconds()
            }
        }


        // 下拉刷新和上拉分页逻辑
        onMovementEnded: {
            console.log("movementEnded: originY:" + originY + ", contentY:" + contentY + ", reflesh:" + root.needReflesh + ", more:" + root.needLoadMore);
            // 刷新
            if (root.needReflesh){
                lv.headerItem.goState('load');
                model.reflesh();
                root.needReflesh = false;
            }
            // 加载新数据
            if (root.needLoadMore){
                model.loadMore();
                root.needLoadMore = false;
            }

            // 拖动过小自动隐藏
            if (contentY<0 && -contentY <= lv.headerItem.height)
                contentY = 0;
        }
        onContentYChanged: {
            // 下拉刷新判断逻辑：已经到头了，还下拉一定距离
            if (contentY < originY){
                var dy = contentY - originY;
                if (dy < -10){
                    //console.log(root.pressed);
                    lv.headerItem.goState('ready');
                    needReflesh = true;
                }
                else {
                    if (root.pressed){
                        //console.log(root.pressed);
                        //needReflesh = false;   // 如何判断当前鼠标是否按下？如果是按下状态才能取消刷新
                        lv.headerItem.goState('');
                    }
                }
            }
            // 逻辑有问题：  movementEnded: originY:-30, contentY:-30, reflesh:true, more:true
            // 上拉加载判断逻辑：已经到底了，还上拉一定距离
            if (contentHeight>height && contentY-originY > contentHeight-height){
                var dy = (contentY-originY) - (contentHeight-height);
                console.log("y: " + contentY + ", dy: " + dy);
                if (dy > 40){
                    needLoadMore = true;
                    console.log("originY:" + originY + ", contentY:" + contentY + ", height:" + height + ", contentheight:" + contentHeight);
                }
            }
        }

        // 模型修改后更改状态
        onModelChanged: {
            if (lv.headerItem != null)
                lv.headerItem.goState('ok');
        }
        // 定位到第一个元素（不显示header）
        Component.onCompleted: contentY=0;
        // 动画
        Behavior on contentY{
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
    }

    //-----------------------------------------
    // model
    //-----------------------------------------
    VisualDataModel{
        id: vdm

        function reflesh(){
            console.log('load');
            lv.headerItem.goState('load');
            model.clear();
            for (var i = 0 ; i < 20 ; ++i)
                model.append({"index": i, "content": "Item " + i})
            lv.contentY = 0;
            lv.onModelChanged();
        }
        function loadMore(){
            console.log("more");
            var n = model.count;
            for (var i = n ; i < n+20; ++i)
                model.append({"index": i, "content": "Item " + i})
            lv.onModelChanged();
        }

        model : ListModel{
            Component.onCompleted: vdm.reflesh();
        }
        delegate: Component {
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
                    //onPressed: {root.pressed = true; console.log('pressed');}
                    //onReleased: {root.pressed = false; console.log('released');}
                    //onExited: {root.pressed = false; console.log('exited');}
                }
            }
        }
    }
}
