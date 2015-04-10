import QtQuick 2.0


// 测试state
/*
State 定义一个配置对象和属性的集合
StateGroup 包含一个状态集合和状态变换
PropertyChanges 使用一个State描述属性的改变
ParentChange 重新定义父集，也就是换个父节点
AnchorChanges 在一个状态中改变anchors
*/
Rectangle {
    id: root
    width: 640
    height: 480

    Text {
        id: lblInfo
        font.pixelSize: 30;
        text: "hello world"
        anchors.centerIn: parent
    }

    // 切换状态
    MouseArea{
        anchors.fill: lblInfo;
        onClicked: {
            root.state = (root.state  == 'down') ? '' : 'down';
        }
    }

    // 定义状态（名称、属性变更）
    states: State {
        name: "down";
        PropertyChanges {target: lblInfo; rotation: 180; color: "red"}
        onCompleted: console.log('down')
    }

    // 状态变更时触发的动画（可选）
    transitions: Transition {
        from: ""; to: "down";
        reversible: true
        ParallelAnimation {
            NumberAnimation { properties: "y,rotation"; duration: 500; easing.type: Easing.InOutQuad }
            ColorAnimation { duration: 500 }
        }
    }
}
