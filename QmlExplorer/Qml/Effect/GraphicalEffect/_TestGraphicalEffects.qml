import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"

/**
测试绘图特效
未完成，只做了个框架
事实上，这些Effect都是由Shader实现的
*/
Column {
    id: root
    width: 800
    height: 480
    spacing: 10

    // menu
    Rectangle{
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        color: 'grey'

        TabView{
            anchors.fill: parent
            Tab {
                title: "Blend" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row {
                    Button {text:'Blend'; onClicked: {}}
                }
            }
            Tab {
                title: "Color" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row{
                    Button {text:'BrightnessContrast'; onClicked: {}}
                    Button {text:'ColorOverlay'; onClicked: {}}
                    Button {text:'Colorize'; onClicked: {}}
                    Button {text:'Desaturate'; onClicked: {}}
                    Button {text:'GammaAdjust'; onClicked: {}}
                    Button {text:'HueSaturation'; onClicked: {}}
                    Button {text:'LevelAdjust'; onClicked: {}}
                }
            }
            Tab {
                title: "Gradient" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row {
                    Button {text:'ConicalGradient'; onClicked: {}}
                    Button {text:'LinearGradient'; onClicked: {}}
                    Button {text:'RadialGradient'; onClicked: {}}
                }
            }
            Tab {
                title: "Distortion" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row {
                    Button {text:'Displace'; onClicked: {}}
                }
            }
            Tab {
                title: "Drop Shadow" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row {
                    Button {text:'DropShadow'; onClicked: {}}
                    Button {text:'InnerShadow'; onClicked: {}}
                }
            }
            Tab {
                title: "Blur" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row {
                    Button {text:'*FastBlur'; onClicked: {root.showEffect(fastBlur);}}
                    Button {text:'*GaussianBlur'; onClicked: {root.showEffect(gaussianBlur)}}
                    Button {text:'MaskedBlur'; onClicked: {}}
                    Button {text:'RecursiveBlur'; onClicked: {}}
                }
            }
            Tab {
                title: "Motion Blur" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row {
                    Button {text:'DirectionalBlur'; onClicked: {}}
                    Button {text:'RadialBlur'; onClicked: {}}
                    Button {text:'ZoomBlur'; onClicked: {}}
                }
            }
            Tab {
                title: "Glow" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row {
                    Button {text:'Glow'; onClicked: {}}
                    Button {text:'RectangularGlow'; onClicked: {}}
                }
            }
            Tab {
                title: "Mask" ;
                anchors.topMargin : 3; anchors.leftMargin: 3
                Row {
                    Button {text:'OpacityMask'; onClicked: {}}
                    Button {text:'ThresholdMask'; onClicked: {}}
                }
            }
        }
    }

    // 显隐效果
    // 性能估计会很糟糕，还是动态创建effect组件会合适些
    function showEffect(effector){
        for (var c in effects.children){
            c.visible = false;
            console.log(c)
        }
        effector.visible = true;
    }

    // images
    RowLayout{
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 5
        Image {
            id: bug
            source: "../images/bug.png"
        }

        Item{
            id: effects
            width: bug.width; height: bug.height

            //----------------------------------------
            // effects
            //----------------------------------------
            FastBlur {
                id: fastBlur
                width: bug.width; height: bug.height
                source: bug
                radius: 32
                visible: false
            }

            GaussianBlur {
                id: gaussianBlur
                width: bug.width; height: bug.height
                source: bug
                radius: 8
                samples: 16
                visible: false
            }
        }
    }
}
