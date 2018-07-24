import QtQuick 2.0
import QtQuick.Dialogs 1.2


/**
Effector 示例
*/
Rectangle {
    width: 800; height: 800
    //color: '#1e1e1e'

    Grid {
        anchors.centerIn: parent
        spacing: 20
        rows: 8; columns: 6

        // 源图像
        Image {
            id: img
            width: 100; height: width
            source: './images/tulips.jpg'
            MouseArea{
                anchors.fill: parent
                onClicked: fileDialog1.open();
            }
            FileDialog {
                id: fileDialog1
                nameFilters: ["Jpeg files (*.jpg)", "Png files (*.png)", "All files (*.*)"]
                onAccepted: img.source = fileUrl
            }
        }
        // 遮罩图像
        Image {
            id: img2
            width: 100; height: width
            source: './images/butterfly.png'
            MouseArea{
                anchors.fill: parent
                onClicked: fileDialog2.open();
            }
            FileDialog {
                id: fileDialog2
                nameFilters: ["Png files (*.png)", "All files (*.*)"]
                onAccepted: img2.source = fileUrl
            }
        }
        Text{
            id: txt
            text: 'Qt'
            font.pixelSize: 70
            font.bold: true
            color: 'blue'
        }

        Column{MaskEffector{source: img; mask: img2} Text{text:'mask'}}
        Column{BillboardEffector{source: img}        Text{text:'Billboard'}}
        Column{BlurEffector{source: img}             Text{text:'Blur'}}
        Column{BlurHorizonEffector{source: img}      Text{text:'BlurHorizon'}}
        Column{BlurVerticalEffector{source: img}     Text{text:'BlurVertical'}}
        Column{ChannelEffector{source: img}          Text{text:'Channel'}}
        Column{EmbossEffector{source: img}           Text{text:'Emboss'}}
        Column{GlowEffector{source: img}             Text{text:'Glow'}}
        Column{GrayEffector{source: img}             Text{text:'Gray'}}
        Column{IsolateEffector{source: img}          Text{text:'Isolate'}}
        Column{MagnifyEffector{source: img}          Text{text:'Magnify'}}

        Column{NegativeEffector{source: img}         Text{text:'Negative'}}
        Column{PageCurlEffector{source: img; animationRunning: true; curlExtent: 0.1; rotation:0}         Text{text:'PageCurl'}}
        Column{PixelateEffector{source: img}         Text{text:'Pixelate'}}
        Column{ReflectEffector{source: img}          Text{text:'Reflection'}}
        Column{RippleEffector{source: img}           Text{text:'Ripple'}}
        Column{SepiaEffector{source: img}            Text{text:'Sepia'}}
        Column{SharpenEffector{source: img}          Text{text:'Sharpen'}}
        Column{ThresholdEffector{source: img}        Text{text:'Threshold'}}
        Column{VignetteEffector{source: img}         Text{text:'Vignette'}}
        Column{WarholEffector{source: img}           Text{text:'Warhol'}}
        Column{WaterEffector{source: img}            Text{text:'Water'}}
        Column{WaveEffector{source: img}             Text{text:'Wave'}}
        Column{WobbleEffector{source: img}           Text{text:'Wobble'}}
    }
}
