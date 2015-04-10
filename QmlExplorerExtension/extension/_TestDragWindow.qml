import QtQuick 2.0


/**
点击窗体（非标题栏）可拖动窗体
main中注册
m_pQmlContainer->rootContext()->setContextProperty("window", this);
*/
Rectangle {
    id: window
    width: 600
    height: 600
    color: 'lightgreen'

    // 拖拉窗体
    MouseArea {
        anchors.fill: parent
        property variant previousPosition
        onPressed: {
            previousPosition = Qt.point(mouseX, mouseY)
        }
        onPositionChanged: {
            if (pressedButtons == Qt.LeftButton) {
                var dx = mouseX - previousPosition.x
                var dy = mouseY - previousPosition.y
                window.pos = Qt.point(window.pos.x + dx, window.pos.y + dy)
            }
        }
    }

}
