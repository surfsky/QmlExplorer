import QtQuick 2.0
import QtQuick.Controls 1.2

/*!
Flickable (listview/gridview..) 滚动动画示例
代码移植自 Silica
不清楚Flickable是否已经提供了scroll功能，有空测测
引用FlickableScroller.qml
*/
Rectangle {
    width: 600
    height: 600

    ListView{
        id: lv
        anchors.fill: parent
        model: ListModel {
            Component.onCompleted: {
                for (var i=0; i<100; i++)
                    append({name:"item " + i, cost:0.9});
            }
        }
        delegate: Row{
            spacing: 5
            Text {text: index}
            Text {text: "<b>" + name + "</b>"}
            Text {text: "<i>" + cost + "</i>"}
        }

        // scroller
        property real originY: 0;
        FlickableScroller{
            id: scroller
            flickable: lv;
        }
    }

    FlickableScroller{
        flickable: lv
    }

}
