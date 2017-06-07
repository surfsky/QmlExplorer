import QtQuick 2.2
import QtQuick.Window 2.0


// 展示图片的窗口，会自动适配图片大小
Window {
    id: imageViewer
    minimumWidth: img.width
    minimumHeight: img.height

    title: img.source
    width: img.implicitWidth + 20
    height: img.implicitHeight + 20

    property alias imageUrl : img.source;


    function open(source) {
        img.source = source
        title = source
        width = img.implicitWidth + 20
        height = img.implicitHeight + 20
        visible = true
    }

    Image {
        id: img
        anchors.centerIn: parent
    }
}
