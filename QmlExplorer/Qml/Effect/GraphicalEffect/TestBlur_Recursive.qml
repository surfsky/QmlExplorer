import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import "../../Controls/ColorPicker/"

/**
测试RecursiveBlur
重复执行模糊，有个动态效果
BUG: 程序会崩溃(QT 5.4)
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    RecursiveBlur {
        anchors.horizontalCenter: parent.horizontalCenter
        width: source.width;
        height: source.height
        source: Image {source: "../images/bug.png"}
        radius: sldRadius.value
        loops: sldLoops.value
        transparentBorder: swhTransparentBorder.checked
    }

    //----------------------------------------
    // 控制区
    //----------------------------------------
    Grid{
        width: 400
        height: 300
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 3
        spacing: 10

        Text{text:'radius'}
        Slider {id: sldRadius; minimumValue: 1.0; maximumValue: 16.0; stepSize: 1.0; value: 7}
        Text{text: sldRadius.value}

        Text{text:'loops'}
        Slider {id: sldLoops; minimumValue: 1.0; maximumValue: 70; stepSize: 1.0; value: 50}
        Text{text: sldLoops.value}

        Text{text:'transparentBorder'}
        Switch{id: swhTransparentBorder; checked : false}
    }
}
