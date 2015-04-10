import QtQuick 2.0
import QtGraphicalEffects 1.0


/**
简单的矩形阴影
*/
DropShadow {
    property int targetWidth : 100;
    property int targetHeight : 100;
    property int targetRadius: 10;

    source: Rectangle{
        width: innerRect.width+20
        height: innerRect.height+20
        color: 'transparent'
        Rectangle{
            id: innerRect
            width: targetWidth;
            height: targetHeight;
            radius: targetRadius
        }
    }
    width: source.width
    height: source.height
    horizontalOffset: 3
    verticalOffset: 3
    radius: 8
    samples: 16
    color: "#80000000"
    spread: 0.0
}
