import QtQuick 2.0

/**
横向的spinner控件
qml
    Spinner {
        id: spinnerMinute
        width: root.width/5;
        height: root.height
        focus: true
        itemWidth: 30
        model: 60
        delegate: Text { font.pixelSize: 25; text: index; height: 30 }
    }
*/
Image {
    property alias model: view.model
    property alias delegate: view.delegate
    property alias currentIndex: view.currentIndex
    property real itemWidth: 30

    source: "spinnerh-bg.png"
    clip: true

    PathView {
        id: view
        focus: true
        model: 60
        delegate: Text { font.pixelSize: 25; text: index;  }

        anchors.fill: parent
        pathItemCount: width/itemWidth
        dragMargin: view.height/2      // 扩大可拖拽区域
        preferredHighlightBegin: 0.5   // 高亮居中
        preferredHighlightEnd: 0.5     // 高亮居中
        highlight: Image { source: "spinner-select.png"; width: itemWidth+4; height: view.height}
        path: Path {
            startX: 0; startY: view.height/2
            PathLine { x: view.width; y: view.height/2}
        }
    }

    Keys.onLeftPressed: view.incrementCurrentIndex()
    Keys.onRightPressed: view.decrementCurrentIndex()
}
