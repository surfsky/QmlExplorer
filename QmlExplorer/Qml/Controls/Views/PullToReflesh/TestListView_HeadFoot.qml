import QtQuick 2.4
import QtQuick.Controls 1.2

/**
listview header-footer 测试
    可用于放置下拉刷新、分页等逻辑
    headerPositioning/footerPositioning 可设置头尾位置（qt5.4以后）

复杂的逻辑（如下拉刷新上拉分页等），需要参照flickable的事件来做处理
    属性
        contentY 内容Y坐标。当前显示的内容左上角在整个内容区中的坐标。往上拉该值是正数
        originY ：第一个元素的y坐标（通常为0，如果有header的话，该值为-headerItem.height）
    事件
        movementStarted: 手指按下，并开始移动
        flickStarted: 若移动很快，手指放开后还根据惯性继续滑动
        flickEnded: 惯性滑动停止
        movementEnded: 完全静止
*/
Row{
    width: 800
    height: 400
    spacing: 5
    //orientation: Qt.Horizontal

    //-------------------------------------------
    // Delegate、header、footer
    //-------------------------------------------
    Component{
        id: delegateItem
        Text{
            text: index;
            height: 10
        }
    }
    Component{
        id: headItem
        Rectangle{
            width: parent.width
            height: 20
            color: 'lightblue'
            z:10
            Text{
                text: 'HEADER'
                anchors.centerIn: parent
            }
        }
    }
    Component{
        id: footItem
        Rectangle{
            width: parent.width
            height: 20
            color: 'lightgreen'
            z:10
            Text{
                text: 'FOOTER'
                anchors.centerIn: parent
            }
        }
    }

    //-------------------------------------------
    // 3个列表
    //-------------------------------------------
    ListView {
        width: parent.width*0.33
        height: parent.height
        model: 80
        clip: true
        delegate: delegateItem
        header: headItem
        footer: footItem
        headerPositioning: ListView.InlineHeader
        footerPositioning: ListView.InlineFooter
        Component.onCompleted: positionViewAtBeginning();
    }
    ListView {
        width: parent.width*0.33
        height: parent.height
        model: 80
        clip: true
        delegate: delegateItem
        header: headItem
        footer: footItem
        headerPositioning: ListView.PullBackHeader
        footerPositioning: ListView.PullBackFooter
        Component.onCompleted: positionViewAtBeginning();
    }
    ListView {
        width: parent.width*0.33
        height: parent.height
        model: 80
        clip: true
        delegate: delegateItem
        header: headItem
        footer: footItem
        headerPositioning: ListView.OverlayHeader
        footerPositioning: ListView.OverlayFooter
        Component.onCompleted: positionViewAtBeginning();
    }
}

