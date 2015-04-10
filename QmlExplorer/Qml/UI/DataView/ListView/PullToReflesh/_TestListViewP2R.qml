import QtQuick 2.0
import "../../../../Controls/ScrollBar"
import "../../../../Controls/PageView"


/**
新闻示例
    顶部新闻图片栏
    下拉刷新
    上拉分页
    滚动轴
*/
ListViewP2R{
    id: view
    width: 500
    height: 800
    pageSize: 50
    snapHeader: true

    // 新闻图片栏
    headerComponent: Component{
        PageView{
            id: pv
            width: view.width
            height: 200
            clip: true
            Rectangle{width:pv.width; height:pv.height; color: 'red'}
            Rectangle{width:pv.width; height:pv.height; color: 'green'}
            Rectangle{width:pv.width; height:pv.height; color: 'blue'}
        }
    }

    // 代理
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
    // 数据
    //-----------------------------------------
    onLoad:{
        for (var i = 0 ; i < pageSize ; ++i)
            model.append({"index": i, "content": "Item " + i})
        //return model;
    }
    onLoadMore:{
        for (var i = pageSize*page ; i < pageSize*(page+1); ++i)
            model.append({"index": i, "content": "Item " + i})
        //return model;
    }
}

