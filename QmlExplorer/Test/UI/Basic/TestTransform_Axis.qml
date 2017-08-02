import QtQuick 2.3

/**
设置转动轴可以模拟立体效果
可以模拟出 windows phone 的 cell 点击效果
*/
Item {
    width: 500; height:500
    property double mouseX: mouseArea.mouseX / width - 0.5
    property double mouseY: mouseArea.mouseY / height - 0.5

    Rectangle {
        id: rect
        anchors.centerIn: parent
        width: 400
        height: 400
        color: Qt.rgba(0.35, 0.65, 0.17)
        antialiasing: true
        Text {
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 160
            text: "QML"
        }

        transform: [
            // 沿x轴旋转
            Rotation {
                origin.x: rect.width / 2
                origin.y: rect.height / 2
                axis { x: 1; y: 0; z: 0 }
                angle: -mouseY * 45
            },
            // 沿y轴旋转
            Rotation {
                origin.x: rect.width / 2
                origin.y: rect.height / 2
                axis { x: 0; y: 1; z: 0 }
                angle: mouseX * 45
            }
        ]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
