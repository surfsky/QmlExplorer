import QtQuick 2.0

/**
测试半圆角矩形
*/
Flickable{
    width: 800
    height: 600
    contentHeight: height*2
    contentWidth: 800

    Flow {
        width: 800
        height: 600
        spacing: 10

        Circular{}
        Line{height: 50}
        Parallelogram{}

        PieSlice{
            id: rect
            width: 200
            height: 200
            start: 0
            end: 145
            border.width: 2
            border.color: 'black'
        }
        Polygram{}
        Square{}
        Trapezoid{}
        Triangle{}
        RectangleEx{}

    }

}

