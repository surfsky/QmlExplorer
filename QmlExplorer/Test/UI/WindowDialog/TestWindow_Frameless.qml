import QtQuick 2.3
import QtQml.Models 2.1
import QtQuick.XmlListModel 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2


/**
可拖拽的主窗体
    /无外框
    /可拖拽
    拖动边框放缩
    阴影（可参考qml360）
拖拽的最佳体验还是调用win32api，稳定不抖，可参考360例程
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTCAPTION,     0);  // 标题栏拖动
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTTOP,         0);  // 上边
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTBOTTOM,      0);  // 下边
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTLEFT,        0);  // 左边
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTRIGHT,       0);  // 右边
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTTOPLEFT,     0);  // 左上角
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTBOTTOMLEFT,  0);  // 左下角
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTTOPRIGHT,    0);  // 右上角
    SendMessage(hwnd, WM_NCLBUTTONDOWN, HTBOTTOMRIGHT, 0);  // 右下角
*/
Window {
    id: window
    width: 360
    height: 600
    visible: true
    color: 'black'

    /*
    // 禁止缩放
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height
    */

    flags: Qt.Window | Qt.FramelessWindowHint
    //flags: Qt.Window ^ Qt.WindowTitleHint

    // 这种拖拽方式不稳，请参考360例程，用windows消息来实现，很稳定
    MouseArea {
        id: windowMove
        anchors.fill: parent;
        property int _x : 0
        property int _y : 0
        onPressed: { _x = mouse.x; _y = mouse.y }
        onPositionChanged: {
            window.setX(window.x + (mouse.x - _x));
            window.setY(window.y + (mouse.y - _y));
        }
    }

    Button{
        style: ButtonStyle{
            background: Item{width:control.width; height: control.height}
            label: Text{color: 'white'; text: control.text; font.pixelSize: 20; anchors.centerIn: parent}
        }
        text: 'X'
        width: 30
        height: 30
        x: parent.width - width -2
        y: 2
        onClicked:{
            Qt.quit();
        }
    }
}

