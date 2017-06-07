import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.XmlListModel 2.0



/**
测试可视数据模型（VisualItemModel)
VisualItemModel 和 ObjectModel
    VisualItemModel is now primarily available as ObjectModel
    VisualItemModel continues to be provided, with the same implementation, in QtQuick for compatibility reasons.
    For full details about the type, see the ObjectModel documentation.
*/
Flow {
    width: 640
    height: 480

    // 可视元素模型（直接输出可视元素）
    VisualItemModel {
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
