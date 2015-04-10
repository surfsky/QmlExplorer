import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import SyntaxHighlighter 1.0


/**
语法高亮代码编辑器
    /qml语法高亮
    /行指示器
    /各种编辑接口方法
BUG
    最好还是直接在c++层实现行指示器功能，如果字体不同，行指示器会错行

*/
RowLayout {
    id: containerCode
    anchors.fill: parent
    anchors.topMargin: -1
    anchors.bottomMargin: -1
    anchors.rightMargin: -1

    // 公共属性和方法
    property alias text: textArea.text
    property alias fontName : textArea.font.family
    property alias fontSize : textArea.font.pixelSize
    function undo(){textArea.undo();}
    function redo(){textArea.redo();}
    function copy(){textArea.copy();}
    function paste(){textArea.paste();}


    // 行指示列
    Rectangle {
        id: lineColumn
        Layout.minimumWidth: 30
        Layout.fillHeight: true
        color: '#f0f0f0'
        clip: true
        Column {
            y: -textArea.flickableItem.contentY + 4  ////
            width: parent.width
            Repeater {
                model: textArea.lineCount
                delegate: Text {
                    id: text
                    color: "#474a53"
                    font: textArea.font
                    width: lineColumn.width - 10
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.NativeRendering
                    text: index + 1
                }
            }
        }
    }

    // 高亮代码编辑器
    TextArea{
        id: textArea
        Layout.fillWidth: true
        Layout.fillHeight: true
        visible: true
        wrapMode: TextEdit.NoWrap
        font.family: fontLoader.name
        font.pixelSize: 14
        anchors.leftMargin: 2
        //inputMethodHints: Qt.ImhNoPredictiveText
        //selectByMouse: true

        // 代码高亮
        SyntaxHighlighter {
            id: syntaxHighlighter
        }
        Component.onCompleted: {
            syntaxHighlighter.setHighlighter(textArea)
            textArea.forceActiveFocus()
        }
    }

    // 字体
    FontLoader {
        id: fontLoader
        source: "qrc:/fonts/ubuntumono.ttf"
    }
}
