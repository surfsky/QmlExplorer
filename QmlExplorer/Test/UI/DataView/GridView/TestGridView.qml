import QtQuick 2.3
import QtQuick.Controls 1.2

/*!
测试网格视图（类似资源浏览器大图标模式）
GridView 继承自 Flickable，自带拖动效果
带底色。其实GridView.hightlight已经实现了这个功能，请参考TestGridView_HightLight.qml样例
*/
GridView {
    id: grid
    width:300; height: 300;
    cellWidth: 80; cellHeight: 80
    clip: true

    // 限制拖动方向
    //flickableDirection: Flickable.HorizontalFlick // 限制拖动方向（但设置这个属性后回弹效果没有了）
    //flickDeceleration: 0.01  // 减速因子
    flow: GridView.FlowLeftToRight
    layoutDirection: GridView.LeftToRight
    verticalLayoutDirection: GridView.TopToBottom

    // 代理
    delegate: Rectangle {
        width: grid.cellWidth;
        height: grid.cellHeight
        color: GridView.isCurrentItem ? "lightsteelblue" : "white"
        radius: 5
        Column {
            anchors.fill: parent
            Image { source: portrait; anchors.horizontalCenter: parent.horizontalCenter }
            Text { text: name; anchors.horizontalCenter: parent.horizontalCenter }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: grid.currentIndex = index;
        }
    }

    // 模型
    model: ListModel {
        id: contactModel
        ListElement {name: "Jim Williams"; portrait: "../images/man.png"}
        ListElement {name: "John Brown";   portrait: "../images/man.png"}
        ListElement {name: "Bill Smyth";   portrait: "../images/woman.png"}
        ListElement {name: "Sam Wise";     portrait: "../images/man.png"}
        ListElement {name: "Jim Williams"; portrait: "../images/man.png"}
        ListElement {name: "John Brown";   portrait: "../images/man.png"}
        ListElement {name: "Bill Smyth";   portrait: "../images/woman.png"}
        ListElement {name: "Sam Wise";     portrait: "../images/man.png"}
    }
}
