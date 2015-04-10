import QtQuick 2.0
import QtMultimedia 5.0

/**
图片按钮
    - 点击时收缩
    - 点击时发声
    - 适合在游戏中使用，完全使用图片来定制界面
property
    source
    clickSound
    onClicked
    onPressed
    onExited
*/
BorderImage {
    id: root

    // 属性
    property alias clickSound: sound.source
    property bool clickShink: true
    property alias text : txt.text
    property alias textColor : txt.color
    source: "btn_blue.png"

    // 点击事件
    signal clicked(var mouse);
    signal pressed(var mouse);
    signal exited(var mouse);

    // 点击放缩
    scale: if (clickShink) area.pressed ? 0.8 : 1.0

    // 文字
    Text{
        id: txt
        anchors.centerIn: parent
        text: 'Choose 1'
        color: 'white'
    }

    // 点击声音
    Audio {
        id: sound
        source: "dropwater.wav"
        loops: 1
    }

    // 点击区域
    MouseArea {
        id: area
        anchors.fill: parent
        anchors.margins: -10
        onClicked: {
            if (clickSound != null)
                sound.play();
            root.clicked(mouse);
        }
        onPressed: root.pressed(mouse);
        onExited: root.exited(mouse);
    }
}
