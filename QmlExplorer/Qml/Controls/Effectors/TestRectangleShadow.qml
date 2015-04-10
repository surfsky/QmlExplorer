import QtQuick 2.0

Rectangle {
    width: 800
    height: 600


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
}

