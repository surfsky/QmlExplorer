import QtQuick 2.3
import QtQuick.Controls 1.2

/**
模拟 windows phone 的 live tile 点击效果
    /按下旋转
    /点击旋转全屏
    /显示第二屏
    网格显示live tile
fix
    第二屏出来得比较突兀，考虑用SequentialAnimation
    或者用flipable替代
*/
Rectangle {
    id: root
    width: 600; height:800
    color: 'black'

    // 恢复原始状态
    Button {
        z: 99
        text: 'restore'
        onClicked: tile.state = '';
    }

    // 第二个页面
    Loader{
        id: loader
        z: 98
        visible: false
        anchors.fill: parent
        BusyIndicator{
            id: busy
            running: false;
        }
        onSourceChanged: busy.running = true;
        onLoaded: busy.running = false;
    }

    // 仿live tile
    Rectangle{
        id: tile
        x: (root.width - this.width)/2
        y: (root.height - this.height)/2
        width: 100
        height: 100
        color: 'lightgreen'
        antialiasing: true

        // 角度（如何控制旋转方向？）
        property int angle: 0
        transform: Rotation {
            id: rot45
            origin.x: tile.width / 2
            origin.y: tile.height / 2
            axis { x: 0; y: 1; z: 0 }
            angle: tile.angle
        }

        MouseArea{
            anchors.fill: parent
            onPressed: if(tile.state!='run') tile.state = 'down'
            onReleased: if(tile.state!='run') tile.state = ''
            onClicked: tile.state = 'run'
        }

        // 状态变迁
        states: [
            State {
                name: "down";
                PropertyChanges{target: tile; angle: 15}
            },
            State {
                name: "run";
                PropertyChanges {
                    target: tile;
                    x: 0
                    y: 0
                    width: root.width
                    height: root.height
                    color: "lightblue"
                    angle: 180
                }
            }
        ]

        // 动画
        transitions: [
            Transition{
                to: 'down'
                PropertyAnimation {target: tile; properties: "angle"; duration: 100}
            },
            Transition{
                from:'down'; to: ''
                NumberAnimation { target: tile; properties: "x,y,width,height,angle"; duration: 400}
            },
            Transition{
                from:'run'; to: ''
                ScriptAction{ script:{loader.visible=false;}}
                NumberAnimation { target: tile; properties: "x,y,width,height,angle"; duration: 400}
            },
            Transition{
                to:'run'
                SequentialAnimation{
                    NumberAnimation { target: tile; properties: "x,y,width,height,angle"; duration: 400}
                    ScriptAction{script:{loader.source="TestRectangle.qml"; loader.visible=true;}}
                }
            }
        ]
    }

}
