import QtQuick 2.3
import QtQuick.Controls 1.2


/**
测试BUG：https://bugreports.qt.io/browse/QTBUG-42699
说明：据说动画和时钟一起使用，timer就有可能不准确，但本机测试ok
据说可用 qputenv() 设置 QSG_RENDER_LOOP 解决，找不到合适的机子测试
*/
Item {
    Timer {
        property var lastTime
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (lastTime) {
                console.log(Date.now() - lastTime);
            }
            lastTime = Date.now();
        }
    }
    SequentialAnimation on z {
        loops: Animation.Infinite
        NumberAnimation { from: 0; to: 1; duration: 1000 }
    }
}
