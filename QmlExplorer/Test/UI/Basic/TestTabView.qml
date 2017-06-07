import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1


/*
测试tabView
- 类似windows标准tabcontrol组件
- 无动画效果，也不知道怎么优化
- 自建的TabPage控件请查看“/qml/ui/pages/TabPage”示例
*/
Rectangle{
    width: 800
    height: 600

    // 控制按钮
    Row{
        id: menubar
        width:parent.width
        height: 50
        spacing: 10
        Button{
            text: 'add'
            anchors.verticalCenter: parent.verticalCenter
            onClicked: tabView.addTab('NEW', cmp);
        }
        Button{
            text: 'del'
            anchors.verticalCenter: parent.verticalCenter
            onClicked: tabView.removeTab(tabView.currentIndex);
        }
        Button{
            text: 'get'
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                // tab继承自loader，可用item来获取其子组件
                var tab = tabView.getTab(tabView.currentIndex);
                lblInfo.text = tab.title + ": " + tab.item.color;
            }
        }
        Text{
            id: lblInfo
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // TabView
    TabView {
        id: tabView
        anchors.fill:  parent
        anchors.topMargin: menubar.height
        Tab {
            title: "Red"
            Rectangle { color: "red" }
        }
        Tab {
            title: "Blue"
            Rectangle { color: "blue" }
        }
        Tab {
            title: "Green"
            Rectangle { color: "green" }
        }
        onCurrentIndexChanged: console.log(currentIndex);
    }

    // 供动态生成的组件
    Component{
        id: cmp
        Rectangle{
            anchors.fill: parent
            color: Qt.rgba(Math.random(1000), Math.random(1000), Math.random(1000), 1);
        }
    }
}

