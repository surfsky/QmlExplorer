import QtQuick 2.0


// 测试behavior（属性变更时默认触发的动画）
Column{
    width: 800
    height: 600
    spacing: 10


    Rectangle{
        width: parent.width
        height: 400
        color: 'lightgreen'
        MouseArea{
            anchors.fill: parent
            onClicked: parent.height -= 50;
        }
        Behavior on height{
            //SpringAnimation { spring: 2; damping: 0.2 }
            PropertyAnimation {duration:200; easing.type: Easing.Linear}
        }
    }

    Text {
        id: lblInfo
        text: "hello world"
        color: 'red'
        font.pixelSize: 30;
        MouseArea{
            anchors.fill: parent;
            onClicked: lblInfo.color = Qt.lighter(lblInfo.color);
        }

        // 设置属性变更时触发的默认动画
        Behavior on color {
            ColorAnimation { duration: 400 }
        }
    }
}

