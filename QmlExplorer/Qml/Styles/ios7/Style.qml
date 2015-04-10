import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import "../"


/*
IOS7样式库（用代码实现，主要来自项目gallery）
未实现
*/
StyleBase {
    property Component busyIndicatorStyle : BusyIndicatorStyle{
        indicator: Image {
            visible: control.running
            source: "./busy.png"
            NumberAnimation on rotation {
                running: control.running
                loops: Animation.Infinite
                duration: 2000
                from: 0 ; to: 360
            }
        }
    }
    property Component buttonStyle        : ButtonStyle {
        background: Rectangle {
            implicitHeight: 22
            //implicitWidth: columnWidth
            color: control.pressed ? "darkGray" : control.activeFocus ? "#cdd" : "#ccc"
            antialiasing: true
            border.color: "gray"
            radius: height/2
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                color: "transparent"
                antialiasing: true
                visible: !control.pressed
                border.color: "#aaffffff"
                radius: height/2
            }
        }
    }
    property Component textFieldStyle     :  TextFieldStyle {
        background: Rectangle {
            //implicitWidth: columnWidth
            implicitHeight: 22
            color: "#f0f0f0"
            antialiasing: true
            border.color: "gray"
            radius: height/2
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                color: "transparent"
                antialiasing: true
                border.color: "#aaffffff"
                radius: height/2
            }
        }
    }
    property Component sliderStyle        :  SliderStyle {
        handle: Rectangle {
            width: 18
            height: 18
            color: control.pressed ? "darkGray" : "lightGray"
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
            //implicitWidth: columnWidth
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
    property Component progressBarStyle   : ProgressBarStyle {
        background: Rectangle {
            //implicitWidth: columnWidth
            implicitHeight: 24
            color: "#f0f0f0"
            border.color: "gray"
        }
        progress: Rectangle {
            color: "#ccc"
            border.color: "gray"
            Rectangle {
                color: "transparent"
                border.color: "#44ffffff"
                anchors.fill: parent
                anchors.margins: 1
            }
        }
    }

    property Component checkBoxStyle      : CheckBoxStyle      {}
    property Component comboBoxStyle      : ComboBoxStyle      {}
    property Component radioButtonStyle   : RadioButtonStyle   {}
    property Component spinBoxStyle       : SpinBoxStyle       {}
    property Component statusBarStyle     : StatusBarStyle     {}
    property Component switchStyle        : SwitchStyle        {}
    property Component textAreaStyle      : TextAreaStyle      {}
    property Component toolBarStyle       : ToolBarStyle       {}
    property Component scrollViewStyle    : ScrollViewStyle {
        transientScrollBars: true
        handle: Item {
            implicitWidth: 14
            implicitHeight: 26
            Rectangle {
                color: "#424246"
                anchors.fill: parent
                anchors.topMargin: 6
                anchors.leftMargin: 4
                anchors.rightMargin: 4
                anchors.bottomMargin: 6
                opacity: 0.8
                radius: width/2
            }
        }
        scrollBarBackground: Item {
            implicitWidth: 14
            implicitHeight: 26
        }
    }

    property Component tabViewStyle       : TabViewStyle       {}
    property Component tableViewStyle     : TableViewStyle     {}

}
