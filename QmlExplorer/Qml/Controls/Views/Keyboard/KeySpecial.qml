import QtQuick 2.0

/**
特殊按钮
- 灰色背景
- 点击后会出现放大字样
- 阴影
- 可放文字和图片
*/
Rectangle {
    id: root
    width: 40
    height: 30
    color: '#909090'
    radius: 5

    //
    property alias text : lbl.text;
    property alias image : img.source
    signal inputed(var c);

    Rectangle{
        x:0; y:0
        width: root.width
        height: root.height - 3
        color: '#aaaaaa'
        radius: 5

        Text{
            id: lbl
            text: ''
            font.pixelSize: 12
            anchors.centerIn: parent
        }
        Image{
            id: img
            anchors.centerIn: parent
        }

        MouseArea{
            anchors.fill: parent
            onPressed: {
                lbl.font.pixelSize = 16;
                lbl.font.bold = true;
            }
            onExited: {
                lbl.font.pixelSize = 12
                lbl.font.bold = false;
            }
            onClicked:{
                inputed(root.text);
            }
        }
    }
}
