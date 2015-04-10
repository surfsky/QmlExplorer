import QtQuick 2.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"
import "../../Controls/Forms/AnglePicker"



/**
用到的各种控制组件
*/
Grid{
    width: 400
    height: 300
    anchors.horizontalCenter: parent.horizontalCenter
    columns: 3
    spacing: 10

    Text{text:'threshold'}
    Slider {id: sldThreshold; minimumValue: 0.1; maximumValue: 1.0; stepSize: 0.1; value: 0.3}
    Text{text: sldThreshold.value}

    Text{text:'spread'}
    Slider {id: sldSpread; minimumValue: 0.1; maximumValue: 1.0; stepSize: 0.1; value: 0.5}
    Text{text: sldSpread.value}


    Text{text:'radius'}
    Slider {id: sldRadius; minimumValue: 1.0; maximumValue: 30.0; stepSize: 1.0; value: 8}
    Text{text: sldRadius.value}

    Text{text:'samples'}
    Slider {id: sldSamples; minimumValue: 1.0; maximumValue: 32.0; stepSize: 1.0; value: 16}
    Text{text: sldSamples.value}

    Text{text:'angle'}
    AnglePicker {id: sldAngle; value: 90; width:40; height:40}
    Text{text: Math.round(sldAngle.value)}

    Text{text:'deviation'}
    Slider {id: sldDeviation; minimumValue: 1.0; maximumValue: 32.0; stepSize: 1.0; value: 4}
    Text{text: sldDeviation.value}

    Text{text:'loops'}
    Slider {id: sldLoops; minimumValue: 1.0; maximumValue: 70; stepSize: 1.0; value: 50}
    Text{text: sldLoops.value}


    Text{text:'length'}
    Slider {id: sldLength; minimumValue: 0; maximumValue: 100; stepSize: 1.0; value: 32}
    Text{text: sldLength.value}

    Text{text:'offset-h'}
    Slider {id: sldOffsetH; minimumValue: -10; maximumValue: 10; stepSize: 1.0; value: -3}
    Text{text: sldOffsetH.value}

    Text{text:'offset-v'}
    Slider {id: sldOffsetV; minimumValue: -10; maximumValue: 10; stepSize: 1.0; value: -3}
    Text{text: sldOffsetV.value}

    Text{text:'color'}
    ColorPicker {id: pkrColor; color: '#b0000000'; }
    Item{width:1; height:1}

    Text{text:'fast'}
    Switch{id: swhFast; checked : false; }
    Item{width:1; height:1}

    Text{text:'transparentBorder'}
    Switch{id: swhTransparentBorder; checked : false}


    Text{text:'hue'}
    ColorPalettePicker{id: pkrHue; paletteSize : Qt.size(256, 1); height:20}
    Text{text: pkrHue.hsl.h}

    Text{text:'hue'}
    Slider {id: sldHue; minimumValue: 0; maximumValue: 1.0; stepSize: 0.1; value: 0.2}
    Text{text: sldHue.value}

    Text{text:'saturation'}
    Slider {id: sldSaturation; minimumValue: 0; maximumValue: 1.0; stepSize: 0.1; value: 0.2}
    Text{text: sldSaturation.value}

    Text{text:'lightness'}
    Slider {id: sldLight; minimumValue: -1; maximumValue: 1.0; stepSize: 0.1; value: 0.5}
    Text{text: sldLight.value}
}

