import QtQuick 2.3
import QtQml.Models 2.1
import QtQuick.XmlListModel 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2


/**
透明不规则形状主窗体
*/
Window {
    id: window
    width: 220
    height: 220
    visible: true
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height
    flags: Qt.Window | Qt.FramelessWindowHint
    color: 'transparent'


    // 简易拖拽逻辑（不稳）
    MouseArea {
        id: area
        anchors.fill: parent;
        property int _x : 0
        property int _y : 0
        onPressed: { _x = mouse.x; _y = mouse.y;}
        onPositionChanged: {
            window.setX(window.x + (mouse.x - _x));
            window.setY(window.y + (mouse.y - _y));
        }
    }

    // 中间的
    Rectangle{
        id: tile
        width: 200
        height: 200
        anchors.centerIn: parent
        color: 'lightgreen'

        // 角度
        property int angle: 45
        transform: Rotation {
            id: rot45
            origin.x: tile.width / 2
            origin.y: tile.height / 2
            axis { x: 0; y: 1; z: 0 }
            angle: tile.angle
        }
        PropertyAnimation{
            id: animAngle
            target: tile
            properties: 'angle'
            from: 45;
            to: 360+45;
        }

        // 点击旋转
        MouseArea{
            anchors.fill: parent
            onPressed: {animAngle.start(); mouse.accepted=true;}
        }
    }

    // 关闭按钮
    Button{
        style: ButtonStyle{
            background: Rectangle{width:control.width; height: control.height; radius:width/2; color: 'lightblue'}
            label: Text{color: 'white'; text: control.text; font.pixelSize: 25; anchors.centerIn: parent; anchors.leftMargin:10}
        }
        text: 'X'
        width: 30
        height: 30
        x: parent.width - width -10
        y: 2
        onClicked:{Qt.quit();}
    }
}

