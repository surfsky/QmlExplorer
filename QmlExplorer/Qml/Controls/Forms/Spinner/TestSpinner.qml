import QtQuick 2.0

/**
spinner控件测试
*/
Column {
    width: 600
    height:600
    spacing: 20
    anchors.leftMargin: 10

    Spinner {
        id: spinner
        width: 50; height: 200
        focus: true
        model: 20
        itemHeight: 30
        delegate: Text { font.pixelSize: 25; text: index; height: 30 }
    }
    Text { text: spinner.currentIndex }

    SpinnerH {
        id: spinnerH
        width: 200; height: 50
        focus: true
        model: 20
        itemWidth: 30
        delegate: Text { font.pixelSize: 25; text: index; height: 30 }
    }
    Text { text: spinnerH.currentIndex }
}
