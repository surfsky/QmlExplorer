import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import "."

/**
根据像素密度选择合适的资源
*/
Column{
    x: 20
    width: 800
    height: 400
    spacing: 5
    Image{id: img; source: R.img.logo}
    Text{text: img.source}
    Text{text: "ppi: " + R.ppi}
    Text{text: R.text.solagon}
    Rectangle{
        color: R.style.buttonColor
        width: R.style.buttonWidth
        height: R.style.buttonHeight
        Text{
            anchors.centerIn: parent
            text: "30mm * 9mm"
        }
    }
    Button{text: 'hello world'}

    // 初始化资源库
    Screen.onPixelDensityChanged: {R.init(Screen.pixelDensity);}
}
