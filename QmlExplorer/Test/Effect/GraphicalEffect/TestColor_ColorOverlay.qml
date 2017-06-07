import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/Forms/ColorPicker/"


/**
给不透明的地方上色（photoshop 图层特效>上色效果）
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    Image {
        id: bug
        source: "../images/butterfly.png"
        smooth: true
        visible: false
    }

    ColorOverlay {
        source: bug
        color: pkrColor.color; //"#80800000"

        anchors.horizontalCenter: parent.horizontalCenter
        width: source.width
        height: source.height
    }

    //----------------------------------------
    // 控制区
    //----------------------------------------
    Grid{
        width: 300
        height: 300
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 3
        spacing: 10


        Text{text:'color'}
        ColorPalettePicker{id: pkrColor; color: '#990000'; paletteSize:Qt.size(256,1); height:10; width:200}
        //ColorPicker {id: pkrColor; color: '#990000'; }
        Item{width:1; height:1}
    }
}
