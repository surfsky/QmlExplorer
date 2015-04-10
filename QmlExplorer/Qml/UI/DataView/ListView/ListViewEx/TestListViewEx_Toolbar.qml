import QtQuick 2.0
import "../../../../Controls/PageView"


/**
带工具栏的列表示例
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
    initPosition: 'first'

    // 顶部新闻图片栏
    headerComponent: Component{
        Rectangle{
            width: view.width
            height: 40
            color: '#f0f0f0'

            Rectangle{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                border.color: '#d0d0d0'
                border.width: 1
                height: 24
                radius: height/2
                Text{
                    x: 5
                    text: '请输入查询条件'
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    color: '#b0b0b0'
                }
                Text{
                    x: 5
                    text: 'Q'
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    color: '#b0b0b0'
                }
            }
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

