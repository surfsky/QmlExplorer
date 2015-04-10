import QtQuick 2.0
import "../../../Controls/ScrollBar"
import "../../../Controls/PageView"


/**
新闻示例
    顶部新闻图片栏
    下拉刷新
    上拉分页
    滚动轴
*/
ListView{
    id: view
    width: 500
    height: 800

    // 新闻图片栏
    header: PageView{
        id: pv
        width: view.width
        height: 200
        clip: true
        Rectangle{
            width:pv.width; height:pv.height;
            color: 'red'
        }
        Rectangle{
            width:pv.width; height:pv.height;
            color: 'green'
        }
        Rectangle{
            width:pv.width; height:pv.height;
            color: 'blue'
        }
        Loader {
            width:pv.width; height:pv.height;
            source:'../../Pages/Page1.qml'
        }
    }


    model: 30
    delegate: Column{
        width: parent.width
        height: 30
        Text{text: index; height:19;}
        Rectangle{width: view.width; height:1; color:'#f0f0f0'}
    }

    // 滚动轴
    FlickableScrollBar {
        target: view
        orientation: Qt.Vertical
    }
}

