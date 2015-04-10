import QtQuick 2.0
import QtQuick.Controls 1.2


/**
Component 生命周期测试
    /创建顺序：父节点》子节点
    /销毁顺序：子节点》父节点

destory() 方法
    /无法destory自身或者父节点? 可以，但必须有父节点存在，否则会报错
    onDestruction 事件到底什么时候触发？
        本示例不会触发 Component.onDestruction 事件，why？这个示例直接写代码
        而另外一个示例TestDestory_Self.qml会触发，why？这个示例是用文件保存代码的
    若A有子节点B，若B有某些属性依赖A，如anchors.centerIn:parent，销毁A时会报错，why？

*/
Rectangle {
    id: rect1
    width: 400
    height: 400
    color: 'blue'
    Component.onCompleted: console.log('rect1 construct');
    Component.onDestruction: console.log('rect1 destruct');


    Rectangle{
        id: rect2
        width: 200
        height: 200
        color: 'green'
        anchors.centerIn: parent
        Component.onCompleted: console.log('rect2 construct');
        Component.onDestruction: console.log('rect2 destruct');

        Rectangle{
            id: rect3
            width: 100
            height: 100
            color: 'yellow'
            anchors.centerIn: parent   ////
            Component.onCompleted: console.log('rect3 construct');
            Component.onDestruction: console.log('rect3 destruct');

            Rectangle{
                id: rect4
                width: 50
                height: 50
                color: 'white'
                x: 10
                y: 10
                Component.onCompleted: console.log('rect4 construct');
                Component.onDestruction: console.log('rect4 destruct');
            }
        }
    }


    Row{
        spacing:5
        Button{text: 'destory rect4'; onClicked: rect4.destroy();}
        Button{text: 'destory rect3'; onClicked: rect3.destroy();}
        Button{text: 'destory rect2'; onClicked: rect2.destroy();}
        Button{text: 'destory rect1'; onClicked: rect1.destroy();}
        Button{text: 'quit';      onClicked: Qt.quit();}
    }

}

