import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2


/**
看起来像2个图像合并
但属性displacement实在弄不清楚
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    Image {
        id: bug
        source: "../images/bug.png"
        sourceSize: Qt.size(parent.width, parent.height)
        smooth: true
        visible: false
    }

    Rectangle {
        id: displacement
        width: 200; height: 200
        color: Qt.rgba(0.5, 0.5, 1.0, 1.0)
        visible: false
        Image {
            anchors.centerIn: parent
            source: "../images/glass_normal.png"
            sourceSize: Qt.size(parent.width/2, parent.height/2)
            smooth: true
        }
    }

    Displace {
        source: bug
        displacementSource: displacement
        displacement: sldDisplacement.value

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


        Text{text:'displacement'}
        Slider {id: sldDisplacement; minimumValue: 0; maximumValue: 1.0; stepSize: 0.1; value: 0.2}
        Text{text: sldDisplacement.value}
    }
}
