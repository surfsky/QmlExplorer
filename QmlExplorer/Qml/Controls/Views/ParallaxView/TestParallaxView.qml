import QtQuick 2.0
import "content"


/**
Parallax 视差视图
改自 view 官方示例
*/
Rectangle {
    width: 320; height: 480

    // 视差视图（含三个页面）
    ParallaxView{
        id: parallax
        anchors.fill: parent
        background: "content/pics/background.jpg"
        margin: 10
        model: ListModel {
            Component.onCompleted: {
                append([
                   {icon: "content/pics/yast-wol.png", qml: 'content/Clock.qml', lazy:false},
                   {icon: "content/pics/home-page.png", qml: 'content/Smiley.qml', lazy:false},
                   {icon: "content/pics/yast-joystick.png", qml: '../../../../App/Dial/Dial.qml', lazy:true}
               ]);
            }
        }
    }
}
