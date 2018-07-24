import QtQuick 2.0
import QtQuick.Controls 1.1

/**
带缓存处理的网络图片视图（未完成）
问题：
    Qt对网络图片是如何处理的？
    如果一个窗体同时使用了n张同样的图片，是否只联网获取一次即可
    如果缓存了，存在哪里？内存？硬盘？
*/
Image {
    width: 100
    height: 100
    source: "https://cdn2.hubspot.net/hubfs/149513/Qt2017/qt_logo_with_text_green_rgb.png?t=1532030078207"

    onStatusChanged: {
        if (this.status == Image.Loading)
            indicator.running = true;
        if (this.status == Image.Ready)
            indicator.running = false;
    }

    BusyIndicator{
        id: indicator
        //anchors.fill: parent
        anchors.centerIn: parent
        running: false
    }
}
