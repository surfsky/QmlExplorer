import QtQuick 2.0
import QtGraphicalEffects 1.0


/**
简单的矩形阴影
    Rectangle{
        id: rect
        x: 100
        y: 100
        z: 1  // z要大于0，否则阴影没地方放
        width: 200
        height: 100
        color: 'green'
        radius: 10
        border.width: 2
        border.color: 'white'

        RectangleShadow{radius: 2}

        MouseArea{
            drag.target: rect;
            anchors.fill: parent
        }
    }
*/
DropShadow {
    id: shadow
    property Rectangle target;

    width: target.width+20
    height: target.height+20
    horizontalOffset: 3
    verticalOffset: 3
    radius: 8
    samples: 16
    color: "#80000000"
    spread: 0.0
    source: Rectangle{
        width: shadow.width
        height: shadow.height
        color: 'transparent'
        Rectangle{
            id: innerRect
            width: target.width;
            height: target.height;
            radius: target.radius
        }
    }


    // 自动附到目标矩形下面
    Component.onCompleted: setShadow();
    function setShadow(){
        if (target == null)
            target = parent;
        shadow.parent = target.parent;
        shadow.z = target.z - 1;
        //shadow.x = target.x;
        //shadow.y = target.y;
        shadow.anchors.left = target.left;
        shadow.anchors.top = target.top;
    }
}
