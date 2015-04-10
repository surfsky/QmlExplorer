import QtQuick 2.2
import QtQuick.Controls 1.1


// 信号处理连接器：连接信号和处理方法
// 一般用于动态创建的组件发送的信号处理
// 更多动态创建的代码请查看DynamicalCreate目录
Flow {
    width: 200
    height: 200
    spacing: 20

    // demo1（传统方法创建对象，并处理其消息）
    TestSignal{
        onMessage1:{console.log(msg);}
        onMessage2:{console.log(msg);}
    }

    // demo2（用Connections来处理动态创建的对象所产生的消息）
    Loader {
        id: loader
        source: "TestSignal.qml"
    }
    Connections {
        target: loader.item
        onMessage1: console.log(msg);
        onMessage2: console.log(msg);
    }


    // demo3（用Connections来处理动态创建的对象所产生的消息）
    Component{
        id: cmpt
        Rectangle{
            signal message()
            height: 30;
            width: 100
            color: 'lightgreen'
            MouseArea{
                anchors.fill: parent;
                onClicked: message();
            }
        }
    }
    Loader {
        id: loader3
        sourceComponent: cmpt
    }
    Connections {
        target: loader3.item
        onMessage: console.log('message');
    }

}
