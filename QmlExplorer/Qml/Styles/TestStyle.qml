import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "./style1/" as Style1
import "./style2/" as Style2
import "./style3/" as Style3
import "./touch/"  as TouchStyle
import "./ios7/"   as Ios7Style

/*
QML 样式方案（未全部完成）
参考：https://qt-project.org/wiki/QmlStyling

QML两种类别的样式
(1)QtQuick.Controls 组件的组合样式
    这些控件都有style属性，是组合属性，包括外观字体啥的
    可事先作为属性丢到某个QObject里面去，静态或动态创建这些QObject即可
(2)自定义组件的样式：
    类似QtQuick.Controls样式，可将零散的属性（如按钮色彩）保存到qml文件里面去
    可参考windows系统色板，创建相应的属性，如 ButtonColor
    http://www.slideshare.net/BurkhardStubert/practical-qml-key-navigation/34

根据这两种类别的样式方案，可以做的调整
（1）合并两种样式到同一个样式基类中，子类继承覆盖即可
（2）使用单例模式，就不用再用代码创建了
    // Style.qml
    pragma Singleton
    import QtQuick 2.0
    QtObject {
        property int textSize: 20
        property color textColor: "green"
    }

    // qmldir
    singleton Style Style.qml

    // in use
    import QtQuick 2.0
    import "."  // QTBUG-34418, singletons require explicit import to load qmldir file
    Text {
        font.pixelSize: Style.textSize
        color: Style.textColor
        text: "Hello World"
    }
task
    ios样式
    拖动效果无效

*/
Rectangle {
    id: root
    width: 640
    height: 480

    // 引入样式库（也可以用loader动态载入）
    StyleBase        {id:style0}
    Style1.Style     {id:style1}
    Style2.Style     {id:style2}
    Style3.Style     {id:style3}
    TouchStyle.Style {id:style4}
    Ios7Style.Style  {id:style5}


    // 设置控件样式
    function setStyle(style){
        root.color = style.colorBg;
        text1.color = style.colorText;

        busyIndicator1.style = style.busyIndicatorStyle;
        button1       .style = style.buttonStyle       ;
        checkBox1     .style = style.checkBoxStyle     ;
        comboBox1     .style = style.comboBoxStyle     ;
        progressBar1  .style = style.progressBarStyle  ;
        radioButton1  .style = style.radioButtonStyle  ;
        slider1       .style = style.sliderStyle       ;
        spinBox1      .style = style.spinBoxStyle      ;
        statusBar1    .style = style.statusBarStyle    ;
        switch1       .style = style.switchStyle       ;
        textArea1     .style = style.textAreaStyle     ;
        textField1    .style = style.textFieldStyle    ;
        toolBar1      .style = style.toolBarStyle      ;
        scrollView1   .style = style.scrollViewStyle   ;
        tabView1      .style = style.tabViewStyle      ;
        tableView1    .style = style.tableViewStyle    ;

        // 如何遍历控件，根据控件类型自动设置相应的style？
        // 伪代码
        for (var c in column1.children){
            //var t = (typeof c);
            //var cs = c.constructor;
            //console.log(t);
            //console.log(cs);
            var item = column1.children[c];
            var t = (typeof item);
            var cs = item.constructor;
            //if (typeof c == 'Button') c.style = style.buttonStyle       ;
            //if (c.constructor == Button) c.style = style.buttonStyle       ;
        }
    }

    //-------------------------------------------
    // switch
    //-------------------------------------------
    ToolBar {
        id: toolBar1
        x: 0
        y: 0
        anchors.right: parent.right
        height: 40

        ToolButton {
            id: toolButton1
            y: 9; x: 0
            text: "style1"
            onClicked: root.setStyle(style1);
        }
        ToolButton {
            id: toolButton2
            y: 9; x: 72
            text: "style2"
            onClicked: root.setStyle(style2);
        }
        ToolButton {
            id: toolButton3
            y: 9; x: 142
            text: "style3"
            onClicked: root.setStyle(style3);
        }
        ToolButton {
            id: toolButton4
            y: 9; x: 212
            text: "android"
            onClicked: root.setStyle(style4);
        }
        ToolButton {
            id: toolButton5
            y: 9; x: 282
            text: "ios7"
            onClicked: root.setStyle(style5);
        }
        ToolButton {
            id: toolButton0
            y: 9; x: 356;
            text: "default"
            onClicked: root.setStyle(style0);
        }
    }


    //-------------------------------------------
    // controls
    //-------------------------------------------
    Flickable {
        id: flickable1
        anchors.topMargin: 39
        anchors.fill: parent
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
                flickableItem.interactive: true
                Rectangle {
                    width: 200
                    height : 300
                    color: 'steelblue'
                }
            }

            TableView{
                id:tableView1
                width: 300
            }
        }
    }

}
