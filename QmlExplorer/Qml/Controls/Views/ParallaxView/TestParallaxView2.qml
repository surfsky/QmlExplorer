import QtQuick 2.0
import "content"


/**
Parallax 视差视图
改自 view 官方示例
*/
Rectangle {
    width: 320; height: 480

    // 视差视图（含三个元素）
    ParallaxView2 {
        id: parallax
        anchors.fill: parent
        background: "content/pics/background.jpg"

        // ObjectModel
        Item {
            property url icon: "content/pics/yast-wol.png"
            width: 320; height: 480
            Clock { anchors.centerIn: parent }
        }
        Item {
            property url icon: "content/pics/home-page.png"
            width: 320; height: 480
            Smiley { }
        }
        Item {
            property url icon: "content/pics/yast-joystick.png"
            width: 320; height: 480
            Loader {
                anchors { top: parent.top; topMargin: 10; horizontalCenter: parent.horizontalCenter }
                width: 300; height: 400
                clip: true;
                source: "../Dial/Dial.qml"
            }
        }
    }
}
