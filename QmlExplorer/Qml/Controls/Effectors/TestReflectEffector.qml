import QtQuick 2.0
import QtQuick.Controls 1.2

/**
测试倒影效果
*/
Rectangle {
    id: window
    width: 400
    height: 200
    gradient: Gradient {
        GradientStop { position: 0; color: "lightsteelblue" }
        GradientStop { position: 1; color: "black" }
    }

    Row {
        id: column
        opacity: 0.99 // work around QTBUG-29037
        y: 50
        width: 200
        anchors.horizontalCenter: parent.horizontalCenter
        layer.enabled: true
        layer.smooth: true
        spacing: 10

        Image{
            source: "../Images/qml.png"
            width: 30;
            height:30
        }
        TextField {
            id: input1
            width: parent.width
            height: 30
            focus: true
            text: "A QML text box.."
        }
    }
    ReflectEffector{
        source: column
    }
}
