import QtQuick 2.0
import QtQuick.Controls 1.2


/**
测试ColorPaletterPicker
    - 可设置调色板色块数目，另器自动生成
    - 也可直接设置调色板
*/
Column {
    width: 800
    height: 600
    spacing: 10

    Row{
        spacing: 5
        ColorPalettePicker{id: pkr}
        Text{text: pkr.color}
    }

    Row{
        spacing: 5
        Button{
            text: 'set palette size'
            onClicked: {
                pkr.paletteSize = Qt.size(tbWidth.text, tbHeight.text);
            }
        }
        IntValidator    {id: intVal; bottom:1; top:255;}
        Text{text:'W'; anchors.verticalCenter: parent.verticalCenter}
        TextField{id: tbWidth; text:'9'; validator: intVal; width:50}
        Text{text:'H'; anchors.verticalCenter: parent.verticalCenter}
        TextField{id: tbHeight; text:'1'; validator: intVal; width:50}
    }
    Row{
        spacing: 5
        Button{
            text: 'set custom palette'
            onClicked: {
                pkr.paletteSize = Qt.size(0,0);
                pkr.palette = [
                    ['red',     'green',    'black'],
                    ['#9999ff', '#ff9900',  '#ff0099'],
                    ['#ffff00', 'white',  '#ff99ff'],
                    ['#00ff00', '#999900',  '#ff00ff']
                ];
            }
        }
    }
    Row{
        spacing: 5
        Button{
            text: 'set color'
            onClicked: {
                pkr.color = pkr2.color;
            }
        }
        ColorPicker{
            id: pkr2
            anchors.verticalCenter: parent.verticalCenter
            paletteSize: Qt.size(90, 10)
        }
    }


}

