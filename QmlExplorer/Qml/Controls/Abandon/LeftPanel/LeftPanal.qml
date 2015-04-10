/*********************************************************************
* \brief: a simple hide-able catalog bar
* \author: shawhen
* \date: 2013-05-18
* \version: 0.0.1 alpha
* \note: just a trial sample,hack it for free,wish your share
*********************************************************************/
import QtQuick 2.0
Rectangle {
    id: root
    width: 100; height: 400;
    color: "white"

    // 左侧的抽屉把手
    Rectangle
    {
        id: hideButton
        anchors { top: parent.top; bottom:parent.bottom; left:parent.left; }
        width: 10
        border.width: 0;
        color: "lightblue"
        Text {
            id: hideButtonLabel
            anchors.centerIn: parent;
            text: "<"
        }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if(root.state == '') {
                    root.state = "minSize"
                } else {
                    root.state = ''
                }
            }
        }
    }

    // 菜单
    ListModel {
        id: featureButtonsModel
        ListElement {name: "图片"}
        ListElement {name: "视频"}
        ListElement {name: "音乐"}
    }
    Component {
        id:featureButtonsDelegate
        Rectangle
        {
            id:wrapper;
            width: wrapper.ListView.view.width;
            height: Math.max(wrapper.ListView.view.height/wrapper.ListView.view.model.count,40);
            color: "lightblue";
            border.width: 0;
            Text {
                anchors.centerIn: parent;
                text: model.name;
            }
        }
    }
    ListView
    {
        id:featureButtons
        spacing: 2;
        anchors { top:parent.top; /*right:parent.right;*/ bottom:parent.bottom; left:hideButton.right; }
        width: root.width - hideButton.width;
        clip: true
        model: featureButtonsModel
        delegate:featureButtonsDelegate
    }

    // 状态及变更动画
    states: [
        State {
            name: "minSize"
            PropertyChanges {
                target: hideButtonLabel
                text: ">"
            }
            PropertyChanges {
                target: root
                width: 10;
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation { target: root; property: "width"; duration: 200; easing.type: Easing.InOutQuad }
        }
    ]
}
