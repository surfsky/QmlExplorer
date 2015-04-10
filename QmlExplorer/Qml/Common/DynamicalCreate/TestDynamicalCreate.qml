import QtQuick 2.2
import QtQuick.Controls 1.1

/**动态创建控件*/
Column {
    id: root
    width: 640
    height: 480
    x:10
    y:10
    spacing: 10

    //-----------------------------------
    // 用Loader组件
    //-----------------------------------
    Button {
        text : "更改 Loader's source"
        onClicked: loader1.source = '../../../app/Clock/Clock.qml';
    }
    Loader{
        id: loader1
        source: '../../Controls/tip/Cell.qml'
        onSourceChanged: console.log('loader source changed');
        onLoaded: console.log('loader load ok')
    }


    //-----------------------------------
    // 用Qt.createQmlObject 手工写代码创建
    //-----------------------------------
    Button {
        text : "用Qt.createQmlObject 手写代码创建'"
        onClicked:  {
            var o2 = Qt.createQmlObject(
                'import QtQuick 2.0;
                 Rectangle {color: "red"; width: 20; height: 20}',
                container2,
                ""
                );
        }
    }
    Rectangle {id: container2; width:100; height:100}


    //-------------------------------------
    // Qt.createComponent(根据已有qml文件创建)
    //-------------------------------------
    Button{
        text: 'Qt.createComponent(根据已有qml文件创建)'
        onClicked: {
            var component = Qt.createComponent("../../controls/Cell.qml");   // 注意该方法区分qml文件的大小写
            if (component.status == Component.Ready) {
                var obj = component.createObject(placeHolder1, {color: 'red'});
                //obj.signal.connect(onSignal);
            }
        }
    }
    Item{
        id: placeHolder1
        width: 400
        height: 100
    }


    //-------------------------------------
    // cmp.createObject（根据Component原型复制）
    //-------------------------------------
    Button{
        text: 'cmp.createObject（根据Component原型复制）'
        onClicked: {
            for (var i=0; i<3; i++)
            {
                var obj = cmp.createObject(placeHolder2);
                obj.visible = true;
            }
        }
    }
    Row{
        id: placeHolder2
        width: 400
        height: 100
        spacing: 10
    }
    // 原型
    Component{
        id: cmp
        Rectangle {
            visible: false;
            color: "red"
            width: 100
            height: 100
            radius: 5
        }
    }

    //-------------------------------------
    // cmp.createObject（复制任何组件）
    //-------------------------------------
    Button{
        text: '复制任何组件-失败'
        onClicked: {
            for (var i=0; i<3; i++)
            {
                /*
                var obj = Qt.createQmlObject(
                        'import QtQuick 2.2;import QtQuick.Dialogs 1.1;Loader{}'
                        , placeHolder2
                        );
                obj.sourceComponent = cmp;
                obj.visible = true;
                */
                var obj = redSquare.createObject(placeHolder3);
                obj.visible = true;
            }
        }
    }
    Row{
        id: placeHolder3
        width: 400
        height: 100
        spacing: 10

        Rectangle {
            id: redSquare
            visible: false;
            color: "red"
            width: 100
            height: 100
            radius: 5
        }
    }
}
