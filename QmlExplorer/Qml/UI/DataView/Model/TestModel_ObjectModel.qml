import QtQuick 2.2
import QtQml.Models 2.1


/**
测试ObjectModel
- 自定义listview元素（包括渲染）
- 无法智能识别ObjectModel组件
- 这玩意和 VisualItemModel 有什么区别？
    VisualItemModel is now primarily available as ObjectModel
    VisualItemModel continues to be provided, with the same implementation, in QtQuick for compatibility reasons.
    For full details about the type, see the ObjectModel documentation.
*/
Rectangle {
    ObjectModel {
        id: itemModel
        Rectangle { height: lv.height; width: lv.width; color: "red" }
        Rectangle { height: lv.height; width: lv.width; color: "green" }
        Rectangle { height: lv.height; width: lv.width; color: "blue" }
    }

    ListView {
        id: lv
        anchors.fill: parent
        model: itemModel
        orientation: ListView.Horizontal        // 横向放置
        snapMode: ListView.SnapOneItem          // 只显示一个元素
        boundsBehavior: Flickable.StopAtBounds  // 到最边了就不允许拖拽
    }
}
