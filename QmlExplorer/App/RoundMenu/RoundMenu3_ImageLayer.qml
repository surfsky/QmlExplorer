import QtQuick 2.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0


/**
方案3(ok)：
    放一个中空的png图片做前景
    pathview放中间，请参考Spinner
    夹心饼干背景放最下面
*/
Item{
    id: root
    width:400
    height:400


    // 背景
    Rectangle{
        anchors.fill: parent
        color: 'black'
        Rectangle{
            width: parent.width;
            height:parent.height/3
            anchors.centerIn: parent
            color: 'lightblue'
        }
    }

    // 子控件
    PathView {
        id: view
        anchors.fill: parent
        property real itemHeight : height/model.count

        path: Path {
            startX: view.width/2;  startY: view.itemHeight/2
            PathLine { x: view.width/2; y: view.height+view.itemHeight/2}
        }
        model: ListModel {
            ListElement {name: "Apple"; cost: 2.45}
            ListElement {name: "Orange"; cost: 3.25}
            ListElement {name: "Banana"; cost: 1.95}
        }
        delegate: Row{
            id: wrapper
            height: view.itemHeight
            spacing:10
            Text {
                text: name; font.pixelSize: 80;
                anchors.verticalCenter: parent.verticalCenter
                color: wrapper.PathView.isCurrentItem ? "red" : "white"
            }
        }
    }

    // 前景遮罩
    Image{
        source: 'bg.png'
        anchors.fill: parent
    }
}

