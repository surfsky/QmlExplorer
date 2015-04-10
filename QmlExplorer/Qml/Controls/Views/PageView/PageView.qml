import QtQuick 2.0

/**
分页视图
    左右分页滑动列表组件
示例
    PageView{
        id: pv
        width: 300
        height: 200
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
    }
作者: surfsky.cnblogs.com 2014-12
*/
ListView{
    id: root
    width: 500
    height: 500
    model: pageModel

    // 可视元素模型（直接输出可视元素）
    default property alias content: pageModel.children
    VisualItemModel {id: pageModel}

    // 横向、只显示一个
    orientation: ListView.Horizontal
    snapMode: ListView.SnapOneItem
    highlightRangeMode: ListView.StrictlyEnforceRange
    cacheBuffer: 3
    boundsBehavior: Flickable.StopAtBounds

    // 当前页指示器
    ListViewIndicator{
        target : root
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        z: 2
    }
}
