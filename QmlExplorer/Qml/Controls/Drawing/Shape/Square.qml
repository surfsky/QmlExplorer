import QtQuick 2.0

/**
正方形
*/
Polygram {
    width: 100
    height: width

    points: [
        Qt.point(0, 0),
        Qt.point(width, 0),
        Qt.point(width, width),
        Qt.point(0, width)
    ]
}
