import QtQuick 2.0
import "../PageView"
import PageView 1.0

/**
新闻示例
    下拉刷新
    上拉分页
    滚动轴
    顶部工具栏
    顶部工具栏自动吸附
    当前行高亮
Author: surfsky.cnblogs.com 2015-01
*/
ListViewEx{
    id: view
    width: 500
    height: 800
    pageSize: 50
    snapHeader: true
    initPosition: 'header'

    // 顶部新闻图片栏
    headerComponent: Component{
        PageView{
            id: pv
            width: view.width
            height: 200
            clip: true
            Rectangle{width:pv.width; height:pv.height; color: 'green'}
            Rectangle{width:pv.width; height:pv.height; color: 'yellow'}
            Rectangle{width:pv.width; height:pv.height; color: 'blue'}
        }
    }

    // 行UI代理
    delegate: Text {
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

    // 高亮
    highlight: Rectangle {
        width: parent.width
        color: "steelblue";
        opacity: 0.5
    }



    //-----------------------------------------
    // 数据加载事件
    //-----------------------------------------
    onLoad:{
        for (var i = 0 ; i < pageSize ; ++i)
            model.append({"index": i, "content": "Item " + i})
    }
    onLoadMore:{
        for (var i = pageSize*page ; i < pageSize*(page+1); ++i)
            model.append({"index": i, "content": "Item " + i})
    }
}

