import QtQuick 2.0

/**
平行四边形
*/
Polygram{
    property point pt1: Qt.point(0, height);
    property point pt2: Qt.point(width*3/4, height);
    property point pt3: Qt.point(width, 0);
    property point pt4: Qt.point(width/4, 0);
    points : [pt1, pt2, pt3, pt4];
}
