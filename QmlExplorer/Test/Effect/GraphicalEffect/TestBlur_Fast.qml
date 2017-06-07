import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2

/**
测试FastBlur
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    FastBlur {
        id: fastBlur
        width: source.width;
        height: source.height
        source: Image {source: "../images/bug.png"}
        radius: sldRadius.value
        transparentBorder: swhTransparentBorder.checked
        anchors.horizontalCenter: parent.horizontalCenter
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
        Slider {id: sldRadius; minimumValue: 1.0; maximumValue: 64.0; stepSize: 1.0; value: 32}
        Text{text: sldRadius.value}

        Text{text:'transparentBorder'}
        Switch{id: swhTransparentBorder; checked : false}
    }
}
