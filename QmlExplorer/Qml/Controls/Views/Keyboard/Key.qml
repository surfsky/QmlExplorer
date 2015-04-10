import QtQuick 2.0


/**
普通字符按钮
- 点击后会出现放大字样
- 阴影
*/
Rectangle {
    id: root
    width: 40
    height: 30
    color: '#909090'
    radius: 5

    // 公共属性
    property string text : 'A';
    signal inputed(var c);


    // 点击显示面板
    Rectangle{
        id: popup
        z:2
        width: Math.max(100, txtBig.width+10)
        height: 100
        radius: 20
        border.width: 1
        border.color: '#e0e0e0'
        anchors.horizontalCenter: parent.horizontalCenter
        y: -150
        visible: false
        Text{
            id:txtBig
            text: root.text
            font.pixelSize: 50
            font.bold: true
            anchors.centerIn: parent
        }
        // 牵引线
        Rectangle{
            width: 30
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            y:100
            gradient: Gradient{
                GradientStop { position: 0.0; color: "#e0e0e0" }
                GradientStop { position: 1.0; color: "white" }
            }
        }
    }


    // 文字
    Rectangle{
        x:0; y:0
        width: root.width
        height: root.height - 3
        color: 'white'
        radius: 5

        Text{
            id: lbl
            text: root.text
            font.pixelSize: 20
            anchors.centerIn: parent
        }

        MouseArea{
            anchors.fill: parent
            onPressed: {
                popup.visible = true;
            }
            onExited: {
                popup.visible = false;
            }
            onClicked:{
                inputed(root.text);
            }
        }
    }
}

