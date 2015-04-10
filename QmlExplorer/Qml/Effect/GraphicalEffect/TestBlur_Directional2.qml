import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

/**
测试运动模糊
*/
Item {
    anchors.fill: parent

    Image {
        id: image
        anchors.centerIn: parent
        source: "../images/qml.png"
    }

    DirectionalBlur {
        anchors.fill: image
        source: image
        length: 64
        samples: 24
        transparentBorder: true

        // 添加动画（angle）
        NumberAnimation on angle {
            from: 0
            to: 180
            duration: 2000
            loops: NumberAnimation.Infinite
        }
    }
}
