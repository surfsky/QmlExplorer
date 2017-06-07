import QtQuick 2.2
import QtQuick.Controls 1.1

/**
显示系统字体列表
*/
Column{
    id: root
    width:480
    height:640

    // 可运行，但会报一堆的log
    // Unable to resolve 'glConvolutionParameteriv'...
    ComboBox {
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        id: comboBox2
        width:300
        editable: true //??如何只选，不让输入
        model: Qt.fontFamilies()
        onAccepted: console.log(currentText)
        onCurrentIndexChanged: console.log(model.get(currentIndex))  // 有问题
    }

    //
    ListView {
        id: lv
        anchors.fill: parent
        anchors.topMargin: 100
        model: Qt.fontFamilies()
        delegate: Item {
            height: 40; width: ListView.view.width
            Text {
                anchors.centerIn: parent
                text: modelData
                font.family: modelData
                font.pixelSize: 20
                color: "steelblue"
            }
        }
    }

}
