import QtQuick 2.3


/**
顶图旋转缩小退场
**/
Rectangle {
    id: page
    width: myRect.width;
    height: myRect.height;
    property bool go : false
    
    // 底图
    Image {
        id: myRect
        state:"OldState"
        source: "Image/pic2.png"
    }
    
    // 顶图
    Image{
        id: movingRect
        source: "Image/pic1.png"
        opacity: 1

        // 旋转角度（角度由定时器控制）
        property double zAngle: 0
        transform: Rotation {
            origin.x: 180 ; origin.y: 320;
            axis {x:1; y:1; z:1}
            angle:movingRect.zAngle
        }


        // 状态变更：更改宽度高度
        // 宽度高度变更动画
        states: State {
            name: "moved";
            when: go
            PropertyChanges { target: movingRect; width: 0 }
            PropertyChanges { target: movingRect; height: 0 }
        }
        Behavior on width {NumberAnimation { properties:"width"; duration: 2000 }}
        Behavior on height {NumberAnimation { properties:"height"; duration: 2000 }}

        // 点击触发动画
        MouseArea {
            anchors.fill: parent;
            onClicked: go = true;
        }
    }


    // 定时器：定时更改角度
    Timer {
        interval: 1;
        running: go;
        repeat: true;
        onTriggered: {
            movingRect.zAngle = movingRect.zAngle + 5
        }
    }

}
