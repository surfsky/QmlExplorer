import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0


/**
字体测试（5.3.1）
    - 全部ok，没有乱码现象，而且中英文显示完整
    - fontSize 和 pointSize 的匹配试验为成功


字体测试（5.3.0）
    现象：
    - 汉字有乱码现象，而且现象不稳定（如黑体一会有效，一会又是乱码）
    结论：
    - 要正确显示中文，必须采用中文字体（逻辑又糊涂了）
    - 小文字很模糊
*/
Flickable{
    width: 480
    height: 640
    contentWidth: width
    contentHeight: height*2

    // 屏幕密度
    property double dp:  Screen.pixelDensity;              // 每毫米多少个像素
    property double dpi: Screen.pixelDensity*25.4          // 每英寸多少个像素（每英寸25.4mm）
    property double dpp: Screen.pixelDensity*25.4/64;      // 每点多少个像素（每英寸72个点）
    //property double dpp: Screen.pixelDensity*25.4/72;      // 每点多少个像素（每英寸72个点）

    Column{
        id: root
        anchors.fill: parent
        anchors.leftMargin: 10
        spacing: 10


        //
        Text{text: "---- Test font family ----"}
        Text{text: "hello, world!"}
        Text{text: "你好，世界！"}
        Text{text: "hello, world! 你好，世界！"}
        Text{text: "hello, world! 你好，世界！"; font.family: "Arial"}
        Text{text: "hello, world! 你好，世界！"; font.family: '宋体'}
        Text{text: "hello, world! 你好，世界！"; font.family: '微软雅黑'}
        Text{text: "hello, world! 你好，世界！"; font.family: '黑体'}    // 乱码
        Text{text: "hello, world! 你好，世界！"; font.family: '仿宋'}    // 乱码


        Text{text: " "}
        Text{text: "---- Test size ----"}
        Text{text: "hello, world! 你好，世界！像素大小"; font.pixelSize: 20}
        Text{text: "hello, world! 你好，世界！点大小（一英寸72个点）"; font.pointSize: 20}

        Text{text: " "}
        Text{text: "---- Test effect ----"}
        Text{text: "hello, world! 你好，世界！"; }
        Text{text: "hello, world! 你好，世界！"; font.bold: true;}
        Text{text: "hello, world! 你好，世界！"; font.italic: true;}
        Text{text: "hello, world! 你好，世界！"; font.strikeout:true}
        Text{text: "hello, world! 你好，世界！"; font.capitalization: Font.Capitalize}
        Text{text: "hello, world! 你好，世界！"; font.underline: true}
        Text{text: "hello, world! 你好，世界！"; font.overline: true}


        Text{text: " "}
        Text{text: "---- Test antialiasing ----"}
        Text{text: "hello, world! 你好，世界！"; font.pixelSize: 24; antialiasing: false}
        Text{text: "hello, world! 你好，世界！"; font.pixelSize: 24; antialiasing: true}


        Text{text: "---- List fonts ----"}
        Text{text: "default font: " + font.family}
        ComboBox {
            id: comboBox2
            width:300
            editable: true
            model: Qt.fontFamilies()
        }


        // 参考 http://blog.csdn.net/liuqz2009/article/details/7208931
        Text{text: "----------字体大小-----------"}
        Text{text: "20个像素的字体"; font.pixelSize: 20;}
        Text{text: "20个点的字体"; font.pointSize: 20;}
        Text{text: "20个点的字体（计算得出有偏差）"; font.pixelSize: 20*dpp;}
        Text{text: "30个像素的字体"; font.pixelSize: 30;}
        Text{text: "30个点的字体"; font.pointSize: 30;}
        Text{text: "30个点的字体（计算得出有偏差）"; font.pixelSize: 30*dpp;}
    }
}
