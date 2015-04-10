import QtQuick 2.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0


/**
目标：实现类似百事可乐的菜单
    /圆球+中间的一个条带
    /里面用listview显示菜单
    listview 拖动时不能显示到圆球外
    listview 拖动时，采用粘连方式，自动滑并固定到某一个选择项。

解决方案
    不规则外观问题
        （1）因为性能考虑，item.clip都是矩形的（Qt 5.3），故不能用简单的rectangle+radius+clip来实现。
        （2）可参考的方案有：
            ImageMask
            OpacityMask
            Canvas
            Shader
            直接放一个做好的图片
    不规则组件事件的响应
        可用ImageMouseArea
    子元素的拖动出界问题
        放一个中空的png图片做前景
        子控件放中间
        底层背景层

以下是方案1：
    用Rectangle+radius+clip来实现背景
    子控件出界问题未解决
*/
Rectangle{
    id: root
    width: 500
    height: 500
    radius: width/2
    color: 'black'

    // 中间横条
    Rectangle{
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height/3
        width: parent.width
        clip: true
        Rectangle{
            width: root.width;
            height:root.height
            radius: width/2
            anchors.centerIn: parent
            color: 'lightblue'
        }
    }

    // listview
    ListView{
        id: list
        width: parent.width
        height: parent.height - 100
        clip: true
        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.DragOverBounds
        anchors.centerIn: parent
        spacing: 20
        model: ListModel {
            ListElement {name: "Apple"; cost: 2.45}
            ListElement {name: "Orange"; cost: 3.25}
            ListElement {name: "Banana"; cost: 1.95}
        }
        delegate: Row{
            height: 120
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:10
            //Image {source: 'http://qt-project.org/images/qt13a/Qt-logo.png'}
            Text {text: name; font.pixelSize: 100; color:'white'}
        }
    }
}

