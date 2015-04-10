import QtQuick 2.0


/**
梯形
*/
Polygram {
    property point pt1: Qt.point(0, height);
    property point pt2: Qt.point(width, height);
    property point pt3: Qt.point(width*2/3, 0);
    property point pt4: Qt.point(width*1/3, 0);
    points : [pt1, pt2, pt3, pt4];
}
