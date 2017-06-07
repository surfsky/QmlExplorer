import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2


/**
顶部工具栏
*/
Rectangle {
    id: root;
    width: 320;
    height: 480;

    //-----------------------------------------
    // listview
    //-----------------------------------------
    ListView {
        id: lv;
        z: 1;
        anchors.fill: parent;
        focus: true;
        activeFocusOnTab: true;

        // 定位到第一个元素（不显示header）
        Component.onCompleted: contentY=0;

        // 数据和显示
        model: model;
        delegate: listDelegate;
        highlight: Rectangle {color: "steelblue"; opacity: 0.5}

        // 标题工具栏显隐
        onMovementEnded: {
            console.log("movementEnded: originY:" + originY + ", contentY:" + contentY);
            // 拖动过小自动隐藏
            if (contentY<0 && -contentY <= lv.headerItem.height/2)
                contentY = 0;
            // 拖动过半自动显示
            if (-contentY >= lv.headerItem.height/2)
                contentY = -lv.headerItem.height;
        }

        // 标题工具栏
        header : Rectangle{
            width: parent.width
            height: 40
            color: '#f0f0f0'

            Rectangle{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                border.color: '#d0d0d0'
                border.width: 1
                height: 24
                radius: height/2
                Text{
                    x: 5
                    text: '请输入查询条件'
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    color: '#b0b0b0'
                }
                Text{
                    x: 5
                    text: 'Q'
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    color: '#b0b0b0'
                }
            }
        }


        // 动画
        Behavior on contentY{
            PropertyAnimation { duration: 200; easing.type: Easing.OutExpo }
        }
    }

    //-----------------------------------------
    // model
    //-----------------------------------------
    ListModel{
        id: model;
        Component.onCompleted: {
            for (var i = 0 ; i < 20 ; ++i) {
                append({"index": i, "content": "Item " + i})
            }
            lv.contentY = 0;
        }
    }

    //-----------------------------------------
    // delegate
    //-----------------------------------------
    Component {
        id: listDelegate;
        Text {
            id: wrapper;
            width: parent.width;
            height: 32;
            font.pointSize: 15;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignHCenter;
            text: content;
            color: ListView.view.currentIndex == index ? "white" : "#505050";
            MouseArea {
                anchors.fill: parent;
                onClicked:  wrapper.ListView.view.currentIndex = index;
            }
        }
    }
}
