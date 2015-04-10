import QtQuick 2.0

/**
spinner
    - 类似老虎机那样的，循环显示列表
    - 用PathView来实现
    - 可用键盘控制

usage
    Spinner {
        id: spinnerMinute
        width: root.width/5;
        height: root.height
        focus: true
        itemHeight: 30
        model: 60
        delegate: Text { font.pixelSize: 25; text: index; height: 30 }
    }

改进
    背景图片太粗糙了，找ios6、ios7的抄一个
    声音
*/
Image {
    property alias model: view.model
    property alias delegate: view.delegate
    property alias currentIndex: view.currentIndex
    property real itemHeight: 30

    source: "spinner-bg.png"
    clip: true

    PathView {
        id: view
        focus: true
        model: 60
        delegate: Text { font.pixelSize: 25; text: index; height: 30 }

        anchors.fill: parent
        pathItemCount: height/itemHeight
        dragMargin: view.width/2       // 扩大可拖拽区域
        preferredHighlightBegin: 0.5   // 高亮居中
        preferredHighlightEnd: 0.5     // 高亮居中
        highlight: Image { source: "spinner-select.png"; width: view.width; height: itemHeight+4 }
        path: Path {
            startX: view.width/2; startY: -itemHeight/2
            PathLine { x: view.width/2; y: view.pathItemCount*itemHeight + itemHeight }
        }
    }

    Keys.onDownPressed: view.incrementCurrentIndex()
    Keys.onUpPressed: view.decrementCurrentIndex()
}
