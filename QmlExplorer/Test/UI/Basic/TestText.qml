/**
测试qml提供的几种文本相关控件
- Text, TextInput, TextEdit 是较早出现的QtQuick基础组件
- Label, TextField, TextArea 是在后期QtQuick.Controls中提供的，提供了键盘聚焦等功能
- 个人认为，完全可以用后者取代前者
- 并没有那种实际意义上的富文本编辑器
*/
import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Grid {
    width: 500
    height: 800
    columns: 2
    spacing: 5

    //----------------------------------------------
    // Text, TextInput, TextEdit 是较早出现的QtQuick基础组件
    // 均继承自Item，无边框
    //----------------------------------------------
    // Text(文本，支持简单html标签)
    // import QtQuick 2.2
    // Inherits: Item
    Label{text:'Text'}
    Text{
        id: textItem
        text: "<b>Hello</b> <i>World!</i>"
        //font.family: "楷体"
        font.pixelSize: 12
        wrapMode: Text.WordWrap
        lineHeight: 0.75
    }

    // TextInput（单行可编辑文本)
    // import QtQuick 2.2
    // Inherits: Item
    Label{text:'TextInput'}
    TextInput{
        text: "<b>Hello</b> <i>World!</i>"
        selectByMouse: true; // 鼠标可以选择
        color: focus ? "black" : "gray"
    }

    // TextEdit (多行可编辑富文本。html编辑框)
    // import QtQuick 2.2
    // Inherits: Item
    Label{text:'TextEdit'}
    TextEdit {
        width: 240
        text: "<b>Hello</b> <i>World!</i>"
        font.family: "Helvetica"
        font.pointSize: 12
        color: "blue"
        focus: true
        height: 50
    }

    Label{text:'Text Style'; }
    Row {
        spacing: 5
        Text { font.pointSize: 12; text: "Normal" }
        Text { font.pointSize: 12; text: "Raised"; style: Text.Raised; styleColor: "#AAAAAA" }
        Text { font.pointSize: 12; text: "Outline";style: Text.Outline; styleColor: "red" }
        Text { font.pointSize: 12; text: "Sunken"; style: Text.Sunken; styleColor: "#AAAAAA" }
    }


    Label{text: 'text format'}
    Column {
        Text {
            font.pointSize: 12
            text: "<b>Hello</b> <i>World!</i>"
        }
        Text {
            font.pointSize: 12
            textFormat: Text.RichText
            text: "<b>Hello</b> <i>World!</i>"
        }
        Text {
            font.pointSize: 12
            textFormat: Text.PlainText
            text: "<b>Hello</b> <i>World!</i>"
        }
    }

    //----------------------------------------------
    // 以下控件是在后期 QtQuick.Controls 中提供的
    // Label 继承自Text, 遵守了系统字体和色彩模式？
    // TextField, TextArea 提供了键盘聚焦、边框等功能
    //----------------------------------------------
    // Label（只读标签，继承自Text, Label follows the font and color scheme of the system）
    // import QtQuick.Controls 1.2
    // Since:	 Qt 5.1
    // Inherits: Text
    Label{text:'label'}
    Label {
        text: "<b>Hello</b> <i>World!</i>"
        font.pixelSize: 22
        font.italic: true
        color: "steelblue"
    }

    /*
    // 该方式会报错：Element is not creatable
    // 想不重复写font的话，建一个MyText.qml，把Text或者Label丢进去，设置好字体，以后复用即可
    Label{text:'label font'}
    Label{
        text: "<b>Hello</b> <i>World!</i>"
        font: Font{
            pixelSize: 10
            bold: false
            italic: false
            family: '微软雅黑'
        }
    }
    */

    // TextField（单行可编辑纯文本，带边框）
    // import QtQuick.Controls 1.2
    // Since:	 Qt 5.1
    // Inherits: FocusScope
    Label{text:'TextField'}
    TextField {
        validator: IntValidator {bottom: 11; top: 31;}
        focus: true
        text: "<b>Hello</b> <i>World!</i>"
        width: parent.width*2/3
        textColor: 'orange'

    }

    // TextArea（多行可编辑富文本，带边框）
    // import QtQuick.Controls 1.2
    // Since:	 Qt 5.1
    // Inherits: ScrollView
    Label{text:'TextArea'}
    TextArea {
        text: "<b>Hello</b> <i>World!</i>"
        textColor: "orange"
        width: parent.width*2/3
    }


    // 文本裁剪功能（显示不下用...替代）
    Label{text:'elide'}
    Text {
        text: "file:///D:/coding-qt/_code/_test/QtMobile/QtMobile/qml/Animation/Test"
        width: parent.width/3
        elide: Text.ElideMiddle
    }

    // 文本换行
    Label{text:'wrap'}
    Text {
        text: "file:///D:/coding-qt/_code/_test/QtMobile/QtMobile/qml/Animation/Test"
        font.pixelSize: 20
        width: 200  //font.pixelSize - 5
        wrapMode: Text.WrapAnywhere
        lineHeight: 1.1
    }

}
