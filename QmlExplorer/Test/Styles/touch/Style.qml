import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Particles 2.0
import "../"


/*
触屏样式库（主要来自项目touch）
*/
StyleBase {
    Component.onCompleted: {
        colorBg = "#212126";
        colorText = "white";
    }

    property Component busyIndicatorStyle : BusyIndicatorStyle {
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
    property Component buttonStyle : ButtonStyle {
        panel: Item {
            implicitHeight: 50
            implicitWidth: 320
            BorderImage {
                anchors.fill: parent
                antialiasing: true
                border.bottom: 8
                border.top: 8
                border.left: 8
                border.right: 8
                anchors.margins: control.pressed ? -4 : 0
                source: control.pressed ? "./images/button_pressed.png" : "./images/button_default.png"
                Text {
                    text: control.text
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 23
                    renderType: Text.NativeRendering
                }
            }
        }
    }
    property Component textFieldStyle : TextFieldStyle {
        textColor: "white"
        //font.pixelSize: 28
        background: Item {
            implicitHeight: 50
            implicitWidth: 320
            BorderImage {
                source: "./images/textinput.png"
                border.left: 8
                border.right: 8
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
            }
        }
    }
    property Component sliderStyle : SliderStyle {
        handle: Rectangle {
            width: 30
            height: 30
            radius: height
            antialiasing: true
            color: Qt.lighter("#468bb7", 1.2)
        }

        groove: Item {
            implicitHeight: 50
            implicitWidth: 400
            Rectangle {
                height: 8
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                color: "#444"
                opacity: 0.8
                Rectangle {
                    antialiasing: true
                    radius: 1
                    color: "#468bb7"
                    height: parent.height
                    width: parent.width * control.value / control.maximumValue
                }
            }
        }
    }
    property Component progressBarStyle   : ProgressBarStyle {
        panel: Rectangle {
            implicitHeight: 15
            implicitWidth: 400
            color: "#444"
            opacity: 0.8
            Rectangle {
                antialiasing: true
                radius: 1
                color: "#468bb7"
                height: parent.height
                width: parent.width * control.value / control.maximumValue
            }
        }
    }
    property Component tabViewStyle       : TabViewStyle {
        tabsAlignment: Qt.AlignVCenter
        tabOverlap: 0
        frame: Item { }
        tab: Item {
            implicitWidth: control.width/control.count
            implicitHeight: 50
            BorderImage {
                anchors.fill: parent
                border.bottom: 8
                border.top: 8
                source: styleData.selected ? "./images/tab_selected.png":"./images/tabs_standard.png"
                Text {
                    anchors.centerIn: parent
                    color: "white"
                    text: styleData.title.toUpperCase()
                    font.pixelSize: 16
                }
                Rectangle {
                    visible: index > 0
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                    width:1
                    color: "#3a3a3a"
                }
            }
        }
    }


    property Component checkBoxStyle      : CheckBoxStyle      {}
    property Component comboBoxStyle      : ComboBoxStyle      {}
    property Component radioButtonStyle   : RadioButtonStyle   {}
    property Component spinBoxStyle       : SpinBoxStyle       {}
    property Component statusBarStyle     : StatusBarStyle     {}
    property Component switchStyle        : SwitchStyle {
        groove: Rectangle {
            implicitHeight: 50
            implicitWidth: 152
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                width: parent.width/2 - 2
                height: 20
                anchors.margins: 2
                color: control.checked ? "#468bb7" : "#222"
                Behavior on color {ColorAnimation {}}
                Text {
                    font.pixelSize: 23
                    color: "white"
                    anchors.centerIn: parent
                    text: "ON"
                }
            }
            Item {
                width: parent.width/2
                height: parent.height
                anchors.right: parent.right
                Text {
                    font.pixelSize: 23
                    color: "white"
                    anchors.centerIn: parent
                    text: "OFF"
                }
            }
            color: "#222"
            border.color: "#444"
            border.width: 2
        }
        handle: Rectangle {
            width: parent.parent.width/2
            height: control.height
            color: "#444"
            border.color: "#555"
            border.width: 2
        }
    }
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
            }
        }
        scrollBarBackground: Item {
            implicitWidth: 14
            implicitHeight: 26
        }
    }

    property Component tableViewStyle     : TableViewStyle{}
}
