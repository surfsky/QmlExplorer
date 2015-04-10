import QtQuick 2.0



/**
ListView 当前项指示器
*/
Row {
    // 绑定的ListView组件
    property ListView target;

    spacing: 20
    Repeater {
        opacity: 0.8
        model: target.model.count
        Rectangle {
            width: 5; height: 5
            radius: 3
            color: target.currentIndex == index ? "grey" : "white"
            MouseArea {
                width: 20; height: 20
                anchors.centerIn: parent
                onClicked: target.currentIndex = index
            }
        }
    }
}
