import QtQuick 2.0

/**定时器测试*/
Rectangle {
    width: 200
    height: 100


    Text {
        id: txtTime;
        font.pixelSize: 20;
        anchors.centerIn: parent;
    }

    Timer {
        interval: 1000;
        running: true;
        repeat: true
        onTriggered: txtTime.text = new Date().toLocaleString(Qt.locale("zh_CN"), 'yyyy-MM-dd HH:mm:ss')
    }
}
