import QtQuick 2.0
import QtQuick.Controls 1.2


/**
快捷键测试
*/
Rectangle {
    width: 100
    height: 62
    id: rect

    Text{text: 'press key: r, g, b'; anchors.centerIn: parent}

    Action{shortcut: "r"; onTriggered: rect.color='red'}
    Action{shortcut: "b"; onTriggered: rect.color='blue'}
    Action{shortcut: "g"; onTriggered: rect.color='green'}
}
