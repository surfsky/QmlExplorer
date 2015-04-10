import QtQuick 2.0


/**
转轮抽奖游戏
（1）模式1：点击加速，匀速运行，再点击减速至停止
（2）模式2：根据swipe力度，加速，匀速，减速，停止
没弄明白怎么控制加速、减速（用4、5个linear animation串起来么）
那些曲线都是距离（角度）的实现情况，并非速度曲线
*/
Image {
    id: root
    width: 640
    height: 1008
    source: 'bg.png'
    state: 'stop'
    fillMode: Image.Pad

    // property
    property int angle : disk2.rotation
    property int duraAccelerate : 1000
    property int duraUniform: 2000
    property int duraDecelerate: 1000



    // 转盘
    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        y: 260
        width: disk1.width;
        height: disk1.height;
        color: 'transparent'
        Image{
            id: disk1
            width: sourceSize.width;
            height: sourceSize.height;
            anchors.centerIn: parent
            source: 'disk1.png'
            rotation: 0;
        }
        Image{
            id: disk2
            anchors.centerIn: parent
            source: 'disk2.png'
            onRotationChanged: {
                lblInfo.text = Math.round(disk2.rotation%360);
            }
        }
        Image{
            id: beer
            anchors.centerIn: parent
            source: 'beer.png'
        }
    }

    // 角度值
    Text{
        id: lblInfo
        anchors.horizontalCenter: root.horizontalCenter
        y: 80
        font.pixelSize: 30
        color: 'red'
        text: '0'
    }


    // state
    states: [
         State {name: 'stop'}
        ,State {name: 'running'}
        ,State {name: 'accelerate'}
        ,State {name: 'uniform'}
        ,State {name: 'decelerate'}
    ]
    /*
    states: [
        State {
            name: 'stop'
            ScriptAction{script:{
                animAccelerate.stop();
                animUniform.stop();
                animDecelerate.stop();
            }}
        }
        ,State {
            name: 'accelerate'
            ScriptAction{script:{
                animAccelerate.start();
            }}
        }
        ,State{
            name: 'uniform'
            ScriptAction{script:{
                animUniform.start();
            }}
        }
        ,State{
            name: 'decelerate'
            ScriptAction{script:{
                animDecelerate.start();
            }}
        }
    ]
    */

    // 启动和终止控制
    MouseArea{
        anchors.fill: parent
        onClicked: {
            if (root.state == 'stop'){
                root.state = 'running';
                animAccelerate.start();
                animDisk1.start();
            }
            else if (root.state == 'running'){
                animAccelerate.stop();
                animUniform.stop();
                animDecelerate.start();
            }
        }
    }


    //----------------------------------------
    // 动画
    //----------------------------------------
    // 加速动画(3.6, 1.8)
    SequentialAnimation{
        id: animAccelerate
        onStopped: animUniform.start();
        PropertyAnimation{
            target: disk2
            property: 'rotation'
            loops: 1
            running: false
            from: angle
            to: angle+360
            duration: 100
            easing.type: Easing.Linear
        }
        PropertyAnimation{
            target: disk2
            property: 'rotation'
            loops: -1
            running: false
            from: angle
            to: angle+360
            duration: 200
            easing.type: Easing.Linear
        }
    }

    // 匀速动画(1.44)
    PropertyAnimation{
        id: animUniform
        target: disk2
        property: 'rotation'
        loops: -1
        running: false
        from: angle
        to: angle+360
        duration: 250
        easing.type: Easing.Linear
    }

    // 减速动画(0.72, 0.36, 0.18)
    SequentialAnimation{
        id: animDecelerate
        onStopped: {
            animDisk1.stop();
            root.state = "stop";
        }
        PropertyAnimation{
            target: disk2
            property: 'rotation'
            loops: 1
            from: angle
            to: angle+360
            duration: 500
            easing.type: Easing.Linear
        }
        PropertyAnimation{
            target: disk2
            property: 'rotation'
            loops: 1
            from: angle
            to: angle+360
            duration: 1000
            easing.type: Easing.Linear
        }
        PropertyAnimation{
            target: disk2
            property: 'rotation'
            loops: 1
            from: angle
            to: angle+360
            duration: 2000
            easing.type: Easing.Linear
        }
    }


    //----------------------------------------
    // 动画2
    //----------------------------------------
    RotationAnimation{
        id : animDisk1
        target: disk1
        running: false;
        from: 360;
        to: 0;
        loops: Animation.Infinite;
        duration: 8000
        direction: RotationAnimation.Counterclockwise
        // direction语句一加上就报错，但可以运行。注意逆时针运行，from和to要倒过来写
        // QML RotationAnimation: Cannot animate non-existent property "angle"
    }
}
