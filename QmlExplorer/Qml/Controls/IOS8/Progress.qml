import QtQuick 2.0


/**
平面风格的进度条
*/
Rectangle {
    id: bg
    width: 200
    height: 10
    radius: height/2
    color: '#e0e0e0'
    clip: true

    property double pecent: 0.4
    property alias progressColor: prog.color
    Rectangle{
        id: prog
        x:0; y:0
        height: parent.height
        width: parent.width * parent.pecent
        radius: height/2
        color: '#18a754'
    }
}
