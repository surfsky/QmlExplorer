import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../"


/*
样式库3（基本上摘抄至帮助文档）
*/
StyleBase {

    // button
    property Component buttonStyle : ButtonStyle {
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 25
            border.width: control.activeFocus ? 2 : 1
            border.color: "#888"
            radius: 4
            gradient: Gradient {
                GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
            }
        }
    }


    property Component progressBarStyle   : ProgressBarStyle   {
        background: Rectangle {
            radius: 2
            color: "lightgray"
            border.color: "gray"
            border.width: 1
            implicitWidth: 200
            implicitHeight: 24
        }
        progress: Rectangle {
            color: "lightsteelblue"
            border.color: "steelblue"
        }
    }

    property Component checkBoxStyle      : CheckBoxStyle {
        indicator: Rectangle {
                implicitWidth: 16
                implicitHeight: 16
                radius: 3
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 1
                Rectangle {
                    visible: control.checked
                    color: "steelblue"
                    border.color: "#333"
                    radius: 1
                    anchors.margins: 4
                    anchors.fill: parent
                }
        }
    }

    property Component radioButtonStyle   : RadioButtonStyle   {
        indicator: Rectangle {
                implicitWidth: 16
                implicitHeight: 16
                radius: 9
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 1
                Rectangle {
                    anchors.fill: parent
                    visible: control.checked
                    color: "steelblue"
                    radius: 9
                    anchors.margins: 4
                }
        }
     }

    // slider
    property Component sliderStyle        :  SliderStyle {
        handle: Rectangle {
            width: 18
            height: 18
            color: control.pressed ? "steelblue" : "lightsteelblue"
            border.color: "gray"
            antialiasing: true
            radius: height/2
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                color: "transparent"
                antialiasing: true
                border.color: "#eee"
                radius: height/2
            }
        }

        groove: Rectangle {
            height: 8
            implicitWidth: columnWidth
            implicitHeight: 22

            antialiasing: true
            color: "#ccc"
            border.color: "#777"
            radius: height/2
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                color: "transparent"
                antialiasing: true
                border.color: "#66ffffff"
                radius: height/2
            }
        }
    }

    property Component spinBoxStyle       : SpinBoxStyle       {
        background: Rectangle {
           implicitWidth: 100
           implicitHeight: 20
           border.color: "gray"
           radius: 2
        }
    }
    property Component switchStyle        : SwitchStyle {
        groove: Rectangle {
                implicitWidth: 100
                implicitHeight: 20
                radius: 9
                border.color: control.activeFocus ? "gray" : "lightgray"
                border.width: 1
                color: control.activeFocus ? "steelblue" : "lightsteelblue"
        }
        handle: Rectangle {
                opacity: control.enabled ? 1.0 : 0.5
                implicitWidth: Math.round((parent.parent.width - padding.left - padding.right)/2)
                implicitHeight: control.height - padding.top - padding.bottom

                border.color: control.activeFocus ? Qt.darker(__syspal.highlight, 2) : Qt.darker(__syspal.button, 2)
                property color bg: control.activeFocus ? Qt.darker(__syspal.highlight, 1.2) : __syspal.button
                gradient: Gradient {
                    GradientStop {color: Qt.lighter(bg, 1.4) ; position: 0}
                    GradientStop {color: bg ; position: 1}
                }

                radius: 2
            }
    }

    property Component textAreaStyle      : TextAreaStyle {
        textColor: "#333"
        selectionColor: "steelblue"
        selectedTextColor: "#eee"
        backgroundColor: "#eee"
    }

    property Component textFieldStyle     : TextFieldStyle {
        textColor: "black"
        background: Rectangle {
            radius: 2
            implicitWidth: 100
            implicitHeight: 24
            border.color: "#333"
            border.width: 1
        }
    }

    property Component tabViewStyle       :  TabViewStyle {
        frameOverlap: 1
        tab: Rectangle {
            color: styleData.selected ? "steelblue" :"lightsteelblue"
            border.color:  "steelblue"
            implicitWidth: Math.max(text.width + 4, 60)
            implicitHeight: 20
            radius: 2
            Text {
                id: text
                anchors.centerIn: parent
                text: styleData.title
                color: styleData.selected ? "white" : "black"
            }
        }
        frame: Rectangle { color: "steelblue" }
    }

    property Component busyIndicatorStyle : BusyIndicatorStyle{}
    property Component comboBoxStyle      : ComboBoxStyle      {}
    property Component tableViewStyle     : TableViewStyle     {}
    property Component toolBarStyle       : ToolBarStyle       {}
    property Component scrollViewStyle    : ScrollViewStyle    {}
    property Component statusBarStyle     : StatusBarStyle     {}
}
