import QtQuick 2.0


/**
测试ParentAnimation
via属性干吗用的？
*/
Item {
    width: 800; height: 400

    //-------------------------------------------------
    // 目标rect
    //-------------------------------------------------
    Rectangle {
        id: redRect1
        width: 100; height: 100
        color: "red"
    }
    Rectangle {
        id: redRect2
        x: 400
        width: 100; height: 100
        color: "red"
    }

    //-------------------------------------------------
    // 源rect（点击更换parent）
    //-------------------------------------------------
    // 试验1：用变更state的方式来修改Parent，并触发动画（ok）
    Rectangle {
        id: blueRect
        width: 50; height: 50
        x: 200; y: 100
        color: "blue"

        // 点击切换状态
        MouseArea { anchors.fill: parent; onClicked: blueRect.state = "reparented" }
        states: State {
            name: "reparented"
            ParentChange { target: blueRect; parent: redRect1; x: 10; y: 10 }
        }
        // 触发动画
        transitions: Transition {
             to: "reparented";
            ParentAnimation {
                via: redRect2  ////??
                NumberAnimation { properties: "x,y"; duration: 300 }
            }
        }
    }

    // 试验2：直接指定parent，并手工设置x、y动画（ok）
    Rectangle {
        id: greenRect
        width: 50; height: 50
        x: 300; y: 100
        color: "green"

        // 直接指定parent
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                parent.parent = redRect1;
                parent.x = 10;
                parent.y = 10;
            }
        }
        Behavior on x{NumberAnimation {}}
        Behavior on y{NumberAnimation {}}
    }

    // 试验3：直接指定parent，设置behavior on parent（无法启动动画）
    Rectangle {
        id: yellowRect
        width: 50; height: 50
        x: 400; y: 100
        color: "yellow"

        // 直接指定parent
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                parent.x = 10;
                parent.y = 10;
                parent.parent = redRect1;
            }
        }
        // 动画未启动
        Behavior on parent {
            NumberAnimation { properties: "x,y"; duration: 300 }
        }
    }
}
