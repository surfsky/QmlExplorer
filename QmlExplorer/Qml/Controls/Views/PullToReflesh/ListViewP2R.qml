import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2
import "../../../../Controls/ScrollBar"

/**
下拉刷新和上拉分页逻辑（用gif标志）
    /下拉刷新
    /上拉加载更多
    /滚动栏
    工具栏半拉显隐逻辑
BUG:
    下拉时图标需要调整
    无法实现：下拉后上拉取消刷新
    loading效果（无效）
*/
ListView {
    id: lv;
    z: 1;
    width: 320;
    height: 480;


    //-------------------------------------
    // public
    //-------------------------------------
    property int pageSize : 20;
    property int currentPage : 0;
    property var headerComponent;
    property bool snapHeader: false;    // 是否吸附头部（自动收缩）

    signal load(var model);
    signal loadMore(var model, int page);


    //-------------------------------------
    // private
    //-------------------------------------
    property bool pressed: false;
    property bool needReflesh: false;
    property bool needLoadMore: false;
    function moveToHeader(){
        contentY = -headerItem.loader.height;
    }
    function moveToFirst(){
        contentY = 0;
    }

    //-------------------------------------
    // 数据模型
    //-------------------------------------
    model: ListModel{
        function reflesh(){
            console.log('load');
            if (lv.headerItem != null)
                lv.headerItem.goState('load');
            clear();
            lv.load(this);
            lv.onModelChanged();
            moveToHeader();
            currentPage = 0;
        }
        function loadMore(){
            console.log('load more');
            currentPage++;
            lv.loadMore(this, currentPage);
            lv.onModelChanged();
        }
    }




    //-------------------------------------
    // 下拉刷新区域
    //-------------------------------------
    header : Column{
        width: parent.width
        property alias indicator : headerIndicator
        property alias loader : headerLoader
        function goState(name){
            if (name == '')           {imgHead.source = './images/arrow-down-24.png'; txt.text='下拉可以刷新';}
            else if (name == 'ready') {imgHead.source = './images/arrow-up-24.png';   txt.text='放开即可刷新';}
            else if (name == 'load')  {imgHead.source = './images/loading-32.gif';    txt.text='加载中';}
            else if (name == 'ok')    {imgHead.source = './images/ok-24.png';         txt.text='下拉刷新'; txtDt.text=getDateString();}
        }
        function getDateString(){
            return Qt.formatTime(new Date(), 'HH:mm:ss');
        }

        // 下拉指示器
        Item{
            id: headerIndicator
            width: 130
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            AnimatedImage {
                id: imgHead; x: 7; y: 1;
                source: "./images/arrow-down-24.png"
                playing: true
                visible: true
            }
            Text{
                id: txt; x: 54; y: 2
                color: "#c0c0c0"
                text: '下拉可以刷新'
            }
            Text{
                id: txtDt; x: 54; y: 18
                color: "#c0c0c0"
                text: qsTr("Last Update:")
            }
        }
        // 用户自定义的头部组件（如新闻头条图片列表、工具栏）
        Loader{
            id: headerLoader
            sourceComponent: headerComponent;
        }
    }


    //-------------------------------------
    // 下拉刷新和上拉分页逻辑
    //-------------------------------------
    onMovementEnded: {
        var h1 = lv.headerItem.loader.height;
        var h2 = lv.headerItem.indicator.height;
        console.log("movementEnded: originY:" + originY + ", contentY:" + contentY + ", reflesh:" + needReflesh + ", more:" + needLoadMore);
        // 刷新
        if (needReflesh){
            lv.headerItem.goState('load');
            model.reflesh();
            needReflesh = false;
        }
        // 加载新数据
        else if (needLoadMore){
            model.loadMore();
            needLoadMore = false;
        }
        else {
            console.log("h1:" + h1 + ", h2:" + h2);
            // 头部区自动显隐（拖动过小隐藏头部，反之显示）
            if (snapHeader){
                if (contentY >= -h1/3 && contentY < 0)
                    moveToFirst();
                if (contentY >= -h1 && contentY < -h1/3)
                    moveToHeader();
            }

            // 刷新区自动显隐
            if (contentY >=-(h1+h2) && contentY < -h1)
                moveToHeader();
        }
    }
    onContentYChanged: {
        // 下拉刷新判断逻辑：已经到头了，还下拉一定距离
        if (contentY < originY){
            var dy = contentY - originY;
            if (dy < -10){
                lv.headerItem.goState('ready');
                needReflesh = true;
            }
            else {
                if (pressed){
                    //console.log(pressed);
                    //needReflesh = false;   // 如何判断当前鼠标是否按下？如果是按下状态才能取消刷新
                    lv.headerItem.goState('');
                }
            }
        }
        // 上拉加载判断逻辑：已经到底了，还上拉一定距离
        if (contentHeight>height && contentY-originY > contentHeight-height){
            var dy = (contentY-originY) - (contentHeight-height);
            //console.log("y: " + contentY + ", dy: " + dy);
            if (dy > 40){
                needLoadMore = true;
                //console.log("originY:" + originY + ", contentY:" + contentY + ", height:" + height + ", contentheight:" + contentHeight);
            }
        }
    }

    // 模型修改后更改状态
    onModelChanged: {
        if (lv.headerItem != null)
            lv.headerItem.goState('ok');
    }

    // 定位到第一个元素（不显示header）
    Component.onCompleted: {
        moveToHeader();
        model.reflesh();
    }

    // 动画
    Behavior on contentY{
        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
    }

    // 滚动轴
    FlickableScrollBar {
        target: view
        orientation: Qt.Vertical
    }
}
