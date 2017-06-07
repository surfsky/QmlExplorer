import QtQuick 2.0
import QtQuick.Controls 1.2


/**
获取首行数据
跳到指定元素
*/
Column {
    width: 600
    height: 400
    spacing: 10

    //-------------------------------------------
    // 控制区
    //-------------------------------------------
    Row{
        spacing: 10
        Button{
            text: 'get first visible item'
            onClicked: {
                var item = lv.itemAt(lv.contentX, lv.contentY);
                lblInfo.text = item.text;
            }
        }
        Text{
            id: lblInfo
            verticalAlignment: parent.verticalCenter
        }

        // 用positionViewXXX方法移动（无动画，且不会改变contentY值）
        Button{
            text: 'go first'
            onClicked: {
                lv.positionViewAtBeginning();
                console.log(lv.contentY);
            }
        }
        Button{
            text: 'go last'
            onClicked: {
                lv.positionViewAtEnd();
                console.log(lv.contentY);
            }
        }
        Button{
            text: 'go 5'
            onClicked: {
                lv.positionViewAtIndex(5, ListView.Beginning);
                console.log(lv.contentY);
            }
        }

        // 自己计算位置移动
        Button{
            text: 'move first'
            onClicked: {
                lv.contentY = 0;
            }
        }
        Button{
            text: 'move last'
            onClicked: {
                lv.contentY = lv.contentHeight-lv.height-lv.headerItem.height;
            }
        }
        Button{
            text: 'move 5'
            onClicked: {
                lv.contentY = (10+lv.spacing)*5;
            }
        }
    }

    //-------------------------------------------
    // listview
    //-------------------------------------------
    ListView {
        id: lv
        width: parent.width
        height: 300
        model: 50
        clip: true
        delegate: Component {
            Text{
                text: index;
                height: 10
            }
        }
        header: Rectangle{
            width: parent.width
            height: 20
            color: 'lightblue'
            Text{
                text: 'searchbar'
                anchors.centerIn: parent
            }
        }
        // 显示内容变动动画
        Behavior on contentY {
            NumberAnimation {
                duration: 500
                easing.type: Easing.InExpo
            }
        }
    }
}
