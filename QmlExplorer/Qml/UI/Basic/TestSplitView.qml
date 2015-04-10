import QtQuick 2.0
import QtQuick.Controls 1.2

SplitView {
    width: 800
    height: 600
    orientation: Qt.Horizontal


    // 左面板
    Row{
        id: leftPanel
        width: parent.width * 0.4


        // 区域宽度变更动画
        Behavior on width{
            PropertyAnimation{easing.type: Easing.OutExpo}
        }
        // 菜单区
        Rectangle{
            id: menu
            height: parent.height
            width: parent.width - grib.width
            color: 'lightgreen'
        }
        // 把柄区（点击显隐边栏）
        Rectangle {
            id: grib
            width: 10
            height: parent.height
            color: "gray"
            MouseArea{
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    leftPanel.width = leftPanel.width>grib.width ? grib.width : 300;
                }
            }
        }
    }

    // 主面板
    Rectangle {
        id: mainPanel
        width: parent.width * 0.6
        color: "lightblue"
    }
}
