import QtQuick 2.0
import QtQuick.Controls 1.1


/*!
\brief 带loading效果的image控件（常用于网络图片加载）
*/
Image {
    width: 100
    height: 100
    //source: "http://qt-project.org/images/qt13a/Qt-logo.png"

    onStatusChanged: {
        if (this.status == Image.Loading)
            indicator.running = true;
        if (this.status == Image.Ready)
            indicator.running = false;
    }

    BusyIndicator{
        id: indicator
        anchors.centerIn: parent
        running: false
    }
}
