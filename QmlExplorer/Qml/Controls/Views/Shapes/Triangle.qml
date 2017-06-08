import QtQuick 2.0


/**
三角形
*/
Polygram {
    property point pt1: Qt.point(0, height);
    property point pt2: Qt.point(width, height);
    property point pt3: Qt.point(width/2, 0);
    points: [pt1, pt2, pt3];
}
