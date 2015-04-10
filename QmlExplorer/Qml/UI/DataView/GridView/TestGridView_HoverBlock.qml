import QtQuick 2.3
import QtQuick.Controls 1.2

/*!
测试网格视图（类似资源浏览器大图标模式）
点击某元素，底色块动画漂移到该元素上
其实GridView.hightlight已经实现了这个功能，请参考TestGridView_HightLight.qml样例
*/
GridView {
    id: grid
    width:300; height: 300;
    cellWidth: 80; cellHeight: 80
    clip: true
    z: 1

    // 限制拖动方向
    //flickableDirection: Flickable.HorizontalFlick // 限制拖动方向（但设置这个属性后回弹效果没有了）
    //flickDeceleration: 0.01  // 减速因子
    flow: GridView.FlowLeftToRight
    layoutDirection: GridView.LeftToRight
    verticalLayoutDirection: GridView.TopToBottom

    // delegate
    delegate: Rectangle {
        width: grid.cellWidth;
        height: grid.cellHeight
        //color: GridView.isCurrentItem ? "lightsteelblue" : "white"
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

    // model
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

    // hover block
    Rectangle{
        id: block
        color: 'lightgreen'
        opacity: 0.4
        width: grid.cellWidth
        height: grid.cellHeight
        radius: 5
        z:0
        Behavior on x{PropertyAnimation {duration:200; easing.type: Easing.OutExpo}}
        Behavior on y{PropertyAnimation {duration:200; easing.type: Easing.OutExpo}}
    }
    onCurrentIndexChanged: {
        block.x = grid.currentItem.x;
        block.y = grid.currentItem.y;
    }
}
