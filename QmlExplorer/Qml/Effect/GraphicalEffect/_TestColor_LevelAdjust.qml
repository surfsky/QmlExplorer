import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2

/**
RGBA各色彩通道都进行曲线调整
This effect adjusts the source item colors separately for each color channel.
Source item contrast can be adjusted and color balance altered.
好复杂，请看帮助以及示例程序：testbed/TestLevelAdjust
*/
Column {
    id: root
    width: 800
    height: 600
    spacing: 10

    Image {
        id: butterfly
        source: "../images/butterfly.png"
        smooth: true
        visible: false
    }

    LevelAdjust {
        source: butterfly
        //minimumInput: "#00000000"
        //maximumInput: "#ffffffff"
        minimumOutput: "#00ffffff"
        maximumOutput: "#ff000000"
        //gamma: Qt.vector3d(1.0, 1.0, 1.0)

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

    }
}
