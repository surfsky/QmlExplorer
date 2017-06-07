import QtQuick 2.0
import QtQuick.Controls 1.1


/**
Component 是一堆qml代码的容器
    是避免另写qml文件的一种替代方法
    需要转化为QtObject（QObject）才能放置于其它qml组件中
        使用loader进行转化
        使用createObject()方法进行转化
    同qml文件一样，只能有一个根节点
    除了id以外，不允许写其它任何属性和信号

流程
    qmlcode -> Component -> QtObject
问题
    QtObject 如何反推回去，获取Component？
**/
Column {
    id: root
    width: 640
    height: 480
    spacing: 10

    // Component对象
    Component {
        id: redSquare
        Rectangle {color: "red"; width: 20; height: 20}
    }



    //-------------------------------------------------
    Text{text: '方案一：用Loader把组件转化为QtObject并显示'}
    Loader {
        x: 10; y: 100
        sourceComponent: redSquare
    }



    //-------------------------------------------------
    Button{
        text: '方案二：用component.createObject()方法将现有Component转化为QtObject'
        onClicked: {
            var obj = redSquare.createObject(placehold1, {});
        }
    }
    Item{id: placehold1; width:100; height:50}



    //-------------------------------------------------
    Button{
        text: '方案三：qml文件 -> Component -> QtObject'
        onClicked: {
            var component = Qt.createComponent("Rect1.qml");
            if (component.status == Component.Ready)
                component.createObject(placehold2, {"width": 300});
        }
    }
    Item{id: placehold2; width:100; height:50}


}
