import QtQuick 2.0


/**
视差视图控件
属性
    background:  背景图片
    currentIndex： 当前视图
ObjectModel考虑用传统模型替代
    icon
    qml
*/
Item {
    id: root
    width: 320; height: 480

    // 公共属性
    property string background : "content/pics/background.jpg";
    property int currentIndex: 0;
    property int margin : 10;

    property ListModel model: ListModel {
        Component.onCompleted: {
            append([
               {icon: "content/pics/yast-wol.png", qml: 'content/Clock.qml', lazy:false},
               {icon: "content/pics/home-page.png", qml: 'content/Smiley.qml', lazy:false},
               {icon: "content/pics/yast-joystick.png", qml: '../Dial/Dial.qml', lazy:true}
           ]);
        }
    }


    // 背景图片
    Image {
        id: background
        source: root.background
        fillMode: Image.TileHorizontally
        x: -list.contentX / 2
        width: Math.max(list.contentWidth, parent.width)
    }

    // 子视图
    ListView {
        id: list
        anchors.fill: parent
        currentIndex: root.currentIndex
        onCurrentIndexChanged: root.currentIndex = currentIndex
        orientation: Qt.Horizontal
        boundsBehavior: Flickable.DragOverBounds
        highlightRangeMode: ListView.StrictlyEnforceRange

        snapMode: ListView.SnapOneItem
        model: root.model
        delegate: Item {
            width: root.width;
            height: root.height
            Loader {
                anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
                width: root.width-2*margin;
                height: root.height-2*margin-selector.height-10
                clip: true;
                source: qml ////
            }
        }
    }

    // 底部的图标托盘
    ListView {
        id: selector
        height: 50
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: Math.min(count * 50, parent.width - 20)
        interactive: width == parent.width - 20
        orientation: Qt.Horizontal

        //
        currentIndex: root.currentIndex
        onCurrentIndexChanged: root.currentIndex = currentIndex

        //
        model: root.model
        delegate: Item {
            width: 50; height: 50
            id: delegateRoot
            Image {
                id: image
                source: icon  ////
                scale: 0.8
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { root.currentIndex = index }
            }
            states: State {
                name: "Selected"
                when: delegateRoot.ListView.isCurrentItem == true
                PropertyChanges {
                    target: image
                    scale: 1
                    y: -5
                }
            }
            transitions: Transition {
                NumberAnimation { properties: "scale,y" }
            }
        }

        // 半透明托盘背景
        Rectangle {
            color: "#60FFFFFF"
            x: -10; y: -10; z: -1
            width: parent.width + 20; height: parent.height + 20
            radius: 10
        }
    }
}
