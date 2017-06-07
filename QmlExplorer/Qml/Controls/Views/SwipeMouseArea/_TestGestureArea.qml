import QtQuick 2.0
import Qt.labs.gestures 1.0


/**
GestureArea
    是试验代码，将来并不一定支持。
    "Qt.labs.gestures" is not installed
    只支持移动设备
相应的功能拆分为
    Flickable:  单指拖移
    MouseArea： 单指点击
    PinchArea： 双指挤压旋转
    MultiPointTouchArea： 多点触摸
    至于swipe似乎忘记了，要自己写
其事件
    Signal	Type	Property            Description
    ------  ----    --------            -----------
    onTap	point	position            the position of the tap
    onPan	real	acceleration        the acceleration of the pan
    onPan	point	delta               the offset from the previous input position to the current input
    onPan	point	offset              the total offset from the first input position to the current input position
    onPan	point	lastOffset          the previous value of offset
    onPinch	point	centerPoint         the midpoint between the two input points
    onPinch	point	lastCenterPoint     the previous value of centerPoint
    onPinch	point	startCenterPoint	the first value of centerPoint
    onPinch	real	rotationAngle       the angle covered by the gesture motion
    onPinch	real	lastRotationAngle	the previous value of rotationAngle
    onPinch	real	totalRotationAngle	the complete angle covered by the gesture
    onPinch	real	scaleFactor         the change in distance between the two input points
    onPinch	real	lastScaleFactor     the previous value of scaleFactor
    onPinch	real	totalScaleFactor	the complete scale factor of the gesture
    onSwipe	real	swipeAngle          the angle of the swipe
    onTapAndHold	point position      the position of the tap
*/
Rectangle {
    width: 100
    height: 62

    GestureArea {
        anchors.fill: parent
        onSwipe :{
            console.info(swipeAngle);
        }

        /*
        onPan: ... gesture.acceleration ...
        onPinch: ... gesture.rotationAngle ...
        onSwipe: ...
        onTapAndHold: ...
        onTap: ...
        onGesture: ...
        */
    }

}
