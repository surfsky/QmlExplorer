import QtQuick 2.0
import QtQuick.Controls 1.2


/**
测试半圆角矩形
*/
Column {
    width: 800
    height: 600
    spacing: 10

    ComboBox{
        id: cmb
        model: ['left', 'right', 'top', 'bottom']
        onCurrentIndexChanged: {
            rect.flatSide = model[currentIndex];
        }
    }


    _SemiRoundRectangle{
        id: rect
        width: 200
        height: 100
        flatSide: 'left'
        //border.width: 1
        //border.color: 'black'
    }

}

