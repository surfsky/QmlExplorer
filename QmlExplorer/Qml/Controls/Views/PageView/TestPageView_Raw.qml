import QtQuick 2.0

/**
用swipe手势换页
    /显示
    /页面吸附
    /页面指示器
    lazyload
做成组件
    items: url, lazyload
    indicatorType: number

晕啊，官方示例都实现了：views > ObjectModel
*/
Rectangle {
    id: root
    width: 500
    height: 500

    // 可视元素模型（直接输出可视元素）
    VisualItemModel {
        id: pageModel
        Rectangle{
            width:root.width; height:root.height;
            color: 'red'
        }
        Rectangle{
            width:root.width; height:root.height;
            color: 'green'
        }
        Rectangle{
            width:root.width; height:root.height;
            color: 'blue'
        }
        Loader {
            width:root.width; height:root.height;
            source:'../Page1.qml'
        }
    }

    // listView
    ListView{
        id: view
        anchors.fill: parent
        model: pageModel
        orientation: ListView.Horizontal

        //
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        cacheBuffer: 3  // 缓存区域高度、宽度、元素个数？

        // page indicator
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            z: 2

            spacing: 20
            Repeater {
                opacity: 0.8
                model: view.model.count
                Rectangle {
                    width: 5; height: 5
                    radius: 3
                    color: view.currentIndex == index ? "grey" : "white"
                    MouseArea {
                        width: 20; height: 20
                        anchors.centerIn: parent
                        onClicked: view.currentIndex = index
                    }
                }
            }
        }

    }
}
