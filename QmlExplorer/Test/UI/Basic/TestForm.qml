import QtQuick 2.2
import QtQuick.Controls 1.1

/*
测试Qt quick 表单控件
另外，样式可参考 Styles/TestStyle.qml 文件
*/
Flickable {
    id: flickable1
    width: 640
    height: 480
    contentWidth: 640
    contentHeight: column1.height
    flickableDirection: Flickable.VerticalFlick
    Column {
        id: column1
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent
        spacing: 8

        BusyIndicator{
            id:busyIndicator1
        }


        //------------------------------------
        // 文本相关
        //------------------------------------
        // 文本标签，支持简单html标签
        // Inherits: Item
        Text {
            id: text1
            text: "<b>Hello</b> <i>World!</i>"
        }

        // 文本标签，支持简单html标签
        // Inherits: Text
        Label {
            id: label1
            text: "<b>Hello</b> <i>World!</i>"
        }



        // 展示一行可编辑文本
        // Inherits: Item
        TextInput{
            id: textInput
            width: 300
            RegExpValidator { regExp:/[a-zA-Z0-9]{0,10}/}
        }

        // 显示多行可编辑带格式文本
        // - 无边框
        // - 帮助文档里面是错的，无法显示html标签
        // Inherits: Item
        TextEdit{
            id: textEdit
            width: 300
            text: "<b>Hello</b> <i>World!</i>"
            color: 'blue'
        }

        // 展示单行可编辑纯文本
        // Inherits: FocusScope
        TextField {
            id: textField1
            width:300
            placeholderText: qsTr("Text Field")
        }

        // 显示多行可编辑带格式文本
        // Inherites: ScrollView
        TextArea {
            id: textArea1
            width:300
            height: 131
            text: "<b>Hello</b> <i>World!</i>"
        }


        //------------------------------------
        // 按钮类
        //------------------------------------
        SpinBox {
            id: spinBox1
            width:300
        }

        RadioButton {
            id: radioButton1
            text: qsTr("radio")
            checked: true
        }
        CheckBox {
            id: checkBox1
            text: qsTr("check")
            checked: true
        }


        Switch {
            id:switch1
            checked: true
        }


        ComboBox {
            id: comboBox1
            width:300
            model: ["Paris", "Oslo", "New York"]
        }
        ComboBox {
            id: comboBox2
            width:300
            editable: true
            model: ["Paris", "Oslo", "New York"]
        }

        Button {
            id: button1
            width:300
            text: qsTr("Button")
        }

        Slider {
            id : slider1
            width:300
            height: 22
            maximumValue: 1.0
            //stepSize: 0.1
            value: 0.6
            onValueChanged: {print(value); }
        }

        //------------------------------------
        // 工具栏类
        //------------------------------------
        StatusBar{
            id:statusBar1
            width: 300
        }

        ProgressBar {
            id : progressBar1
            value: slider1.value
            width:300
        }


        //------------------------------------
        // 视图类
        //------------------------------------
        TabView {
            id : tabView1
            width:300
            height: 50
            Tab { title: "One" ; Item {}}
            Tab { title: "Two" ; Item {}}
            Tab { title: "Three" ; Item {}}
            Tab { title: "Four" ; Item {}}
        }


        ScrollView{
            id:scrollView1
            width: 300
            height: 100
            Rectangle {
                height : 300
                color: 'blue'
            }
        }

        TableView{
            id:tableView1
            width: 300
        }
    }
    states: [
        State {
            name: "State1"
        }
    ]
}

