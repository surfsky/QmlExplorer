import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Particles 2.0
import "../"


/*
样式库1（用图片，主要来自项目gallery）
*/
StyleBase {
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
        background: BorderImage {
            source: control.pressed ? "./button-pressed.png" : "./button.png"
            //source: control.enabled
            //    ? (control.pressed ? "button-pressed.png" : "button.png")
            //    : "button-inactive.png"
            //    ;
            border.left: 4 ; border.right: 4 ; border.top: 4 ; border.bottom: 4
        }
    }
    property Component textFieldStyle : TextFieldStyle {
        background: BorderImage {
            source: "./textfield.png"
            border.left: 4 ; border.right: 4 ; border.top: 4 ; border.bottom: 4
        }
    }
    property Component sliderStyle : SliderStyle {
        groove: BorderImage {
            height: 6
            border.top: 1
            border.bottom: 1
            source: "./progress-background.png"
            border.left: 6
            border.right: 6
            BorderImage {
                anchors.verticalCenter: parent.verticalCenter
                source: "./progress-fill.png"
                border.left: 5 ; border.top: 1
                border.right: 5 ; border.bottom: 1
                width: styleData.handlePosition
                height: parent.height
            }
        }
        handle: Item {
            width: 13
            height: 13
            Image {
                anchors.centerIn: parent
                source: "./slider-handle.png"
            }
        }
    }
    property Component progressBarStyle   : ProgressBarStyle {
        background: BorderImage {
            source: "./progress-background.png"
            border.left: 2 ; border.right: 2 ; border.top: 2 ; border.bottom: 2
        }
        progress: Item {
            clip: true
            BorderImage {
                anchors.fill: parent
                anchors.rightMargin: (control.value < control.maximumValue) ? -4 : 0
                source: "./progress-fill.png"
                border.left: 10 ; border.right: 10
                Rectangle {
                    width: 1
                    color: "#a70"
                    opacity: 0.8
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 1
                    anchors.right: parent.right
                    visible: control.value < control.maximumValue
                    anchors.rightMargin: -parent.anchors.rightMargin
                }
            }
            ParticleSystem{ id: bubbles; running: visible }
            ImageParticle{
                id: fireball
                system: bubbles
                source: "./bubble.png"
                opacity: 0.7
            }
            Emitter{
                system: bubbles
                anchors.bottom: parent.bottom
                anchors.margins: 4
                anchors.bottomMargin: -4
                anchors.left: parent.left
                anchors.right: parent.right
                size: 4
                sizeVariation: 4
                acceleration: PointDirection{ y: -6; xVariation: 3 }
                emitRate: 6 * control.value
                lifeSpan: 3000
            }
        }
    }
    property Component tabViewStyle       : TabViewStyle {
        tabOverlap: 16
        frameOverlap: 4
        tabsMovable: true

        frame: Rectangle {
            gradient: Gradient{
                GradientStop { color: "#e5e5e5" ; position: 0 }
                GradientStop { color: "#e0e0e0" ; position: 1 }
            }
            border.color: "#898989"
            Rectangle { anchors.fill: parent ; anchors.margins: 1 ; border.color: "white" ; color: "transparent" }
        }
        tab: Item {
            property int totalOverlap: tabOverlap * (control.count - 1)
            implicitWidth: Math.min ((styleData.availableWidth + totalOverlap)/control.count - 4, image.sourceSize.width)
            implicitHeight: image.sourceSize.height
            BorderImage {
                id: image
                anchors.fill: parent
                source: styleData.selected ? "./tab_selected.png" : "./tab.png"
                border.left: 30
                smooth: false
                border.right: 30
            }
            Text {
                text: styleData.title
                anchors.centerIn: parent
            }
        }
        leftCorner: Item { implicitWidth: 12 }
    }


    property Component checkBoxStyle      : CheckBoxStyle      {}
    property Component comboBoxStyle      : ComboBoxStyle      {}
    property Component radioButtonStyle   : RadioButtonStyle   {}
    property Component spinBoxStyle       : SpinBoxStyle       {}
    property Component statusBarStyle     : StatusBarStyle     {}
    property Component switchStyle        : SwitchStyle        {}
    property Component textAreaStyle      : TextAreaStyle      {}
    property Component toolBarStyle       : ToolBarStyle       {}
    property Component scrollViewStyle    : ScrollViewStyle    {}
    property Component tableViewStyle     : TableViewStyle     {}
}
