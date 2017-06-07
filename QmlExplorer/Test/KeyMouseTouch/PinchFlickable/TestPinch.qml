import QtQuick 2.0


/**
测试PinchArea: 两指手势、缩放、旋转、拖动
请在移动设备上测试
可参考官方示例：D:\Qt\Qt5.3.2\Examples\Qt-5.3\touch\pinchzoom
*/
Rectangle {
    width: 600
    height: 600
    color: 'black'

    Rectangle{
        id: rect
        x: 200; y:200
        width: 200; height:200
        color: 'orange'
    }

    PinchArea{
        anchors.fill: parent
        pinch.target: rect   //
        pinch.minimumScale: 1.0
        pinch.maximumScale: 5.0
        pinch.minimumRotation: 0
        pinch.maximumRotation: 90
        pinch.minimumX: 0
        pinch.maximumX: 300
        pinch.dragAxis: Pinch.XandYAxis
    }
}
