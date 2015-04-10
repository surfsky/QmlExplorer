import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.2



/**
使用物理尺寸
一般情况下，设计师们采用：
    用px来标注图形
    用pt来标注文字，以满足阅读的需要
*/
Grid {
    id: root
    width: 600
    height: 300
    spacing: 10
    columns: 2

    // 屏幕密度
    property double ppmm:  Screen.pixelDensity;              // 每毫米多少个像素
    property double ppi: ppmm*25.4          // 每英寸多少个像素（每英寸25.4mm）
    property double ppp: ppi/64;      // 每点多少个像素（每英寸72个点，不准确，换成64差不多）


    //-------------------------------------------
    Text{text: '固定物理尺寸按钮(30mm*10mm）'}
    BorderImage {
        id: btn1
        source: "./res/btn.png"
        width: 30*ppmm
        height: 10*ppmm
        border { left: 25; top: 25; right: 25; bottom: 25 }
    }


    //-------------------------------------------
    Text{text: '固定文本物理尺寸(20pt)，按钮适配文本'}
    BorderImage {
        id: btn2
        source: "./res/btn.png"
        width: txt.contentWidth + 20
        height: txt.contentHeight + 10
        border { left: 25; top: 25; right: 25; bottom: 25 }
        Text{
            id: txt
            text: 'Button'
            font.pointSize: 20   // 字体尺寸：20个点
            anchors.centerIn: parent
        }
    }

    //-------------------------------------------
    Text{text: '固定文本物理尺寸(12mm)，按钮适配文本'}
    BorderImage {
        source: "./res/btn.png"
        width: txt2.contentWidth + 20
        height: txt2.contentHeight + 10
        border { left: 25; top: 25; right: 25; bottom: 25 }
        Text{
            id: txt2
            text: 'Button'
            font.pixelSize: 12*ppmm  // 12mm
            anchors.centerIn: parent
        }
    }

    //-------------------------------------------
    Text{text: '默认的按钮，字体是用pointSize的'}
    Button{
        text: 'Button'
    }
    Text{text: '测试默认按钮的字体大小(9 pointSize)'}
    Text{
        text: 'Button'
        font.pointSize: 9
    }


    //-------------------------------------------
    // 将窗口从不同密度屏幕拖动（要全部拖过去），pixelDensity就会触发
    //-------------------------------------------
    Screen.onPixelDensityChanged: console.log(Screen.pixelDensity);
}

