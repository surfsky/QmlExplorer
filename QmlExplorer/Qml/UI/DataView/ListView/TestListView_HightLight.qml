import QtQuick 2.0

/**
ListView 当前行高亮效果
*/
Row {
    width: 500;
    height: 300
    spacing: 10

    //------------------------------------------
    // model & delegate
    //------------------------------------------
    ListModel {
        id: pets
        ListElement {name: "Polly"; type: "Parrot"; age: 12; size: "Small"}
        ListElement {name: "Penny"; type: "Turtle"; age: 4;  size: "Small"}
        ListElement {name: "Warren"; type: "Rabbit"; age: 2; size: "Small"}
        ListElement {name: "Spot";   type: "Dog";    age: 9; size: "Medium"}
    }

    Component {
        id: petDelegate
        // 用Item做容器背景是透明的才可以看到hightlight
        // 若用Rectangle记得要设置color为transparent才行
        Item {
            id: wrapper
            width: 200; height: 50
            Column {
                Text { text: 'Name: ' + name }
                Text { text: 'Type: ' + type }
                Text { text: 'Age: ' + age }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: wrapper.ListView.view.currentIndex = index
            }
        }
    }


    //------------------------------------------
    // ListView
    //------------------------------------------
    ListView {
        width: (parent.width-10)/2;
        height: parent.height
        model: pets
        delegate: petDelegate

        // 高亮代理（用系统高亮动画）
        highlight: Rectangle {
            width: parent.width; height: 50
            color: "#FFFF88"
        }
    }


    ListView {
        width: (parent.width-10)/2;
        height: parent.height
        model: pets
        delegate: petDelegate

        // 高亮代理（用自定义高亮动画）
        highlightFollowsCurrentItem: false;
        highlight: Rectangle {
            width: parent.width; height: 50
            color: "#FFFF88"
            y: ListView.view.currentItem.y;
            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
        }
    }

}
