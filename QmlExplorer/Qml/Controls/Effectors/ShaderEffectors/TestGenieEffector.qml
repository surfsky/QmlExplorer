import QtQuick 2.0
import QtQuick.Controls 1.2

/**
测试魔法缩放效果
    /任意item->Image->GenieEffector.source
    改造GenieEffector
        /另其source可处理任何item
        可缩小到任意位置
*/
Rectangle {
    width: 480; height: 240
    ///color: '#1e1e1e'

    // 源组件
    Rectangle {
        id: rect
        width: 200
        height: 100
        radius: 5
        color: 'lightblue'
        anchors.centerIn: parent
        layer.enabled: true
        layer.smooth: true
        TextInput{
            text: 'input'
            focus: true
            anchors.centerIn: parent
        }
    }

    // 魔法缩放效果
    GenieEffector {
        id: effector
        side: 0.2
        source: rect
        anchors.fill: rect
        visible: false;
        onMaxAnimationCompleted: {
            this.visible = false;
            rect.visible = true;
            btn.enabled = true;
            console.log('max ok');
        }
        onMinAnimationCompleted: {
            this.visible = false;
            rect.visible = false;
            btn.enabled = true;
            console.log('min ok');
        }
    }

    // 触发按钮
    Button {
        id: btn
        text: effector.minimized ? 'max' : 'min'
        onClicked: {
            btn.enabled = false;
            if (!effector.minimized){
                rect.visible = false;
                effector.visible = true;
                effector.minimized = true;
            }
            else{
                effector.visible = true;
                effector.minimized = false;
            }
        }
    }
}
