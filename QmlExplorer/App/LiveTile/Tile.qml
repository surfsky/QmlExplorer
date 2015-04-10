import QtQuick 2.0

// 仿live tile
Rectangle{
    id: tile
    width: 100
    height: 100
    color: 'lightgreen'
    antialiasing: true

    // 公共属性
    property Item rootItem;          // 根节点，磁贴翻转全屏用
    property alias text: txt.text   // 标题
    property string tag;             // 附属数据
    signal tileActive(string tag)    // 信号，在磁贴激活时触发

    //
    Text{
        id: txt
        anchors.centerIn: parent
    }


    // 角度（如何控制旋转方向？）
    property int angle: 0
    transform: Rotation {
        id: rot45
        origin.x: tile.width / 2
        origin.y: tile.height / 2
        axis { x: 0; y: 1; z: 0 }
        angle: tile.angle
    }

    // 三态
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
            ParentChange{
                target: tile
                parent: rootItem
            }
            PropertyChanges {
                target: tile;
                x: 0
                y: 0
                width: rootItem.width
                height: rootItem.height
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
                ScriptAction{script:{tileActive(tag);}}
                //ScriptAction{script:{loader.source="TestRectangle.qml"; loader.visible=true;}}
            }
        }
    ]
}
