import QtQuick 2.0
import QtQuick.Controls 1.1


/**
测试MouseArea滑动手势
- 可考虑做复杂手势，如三角形、矩形、圆形的手势解析
- 实际的应用例子可查看： /App/SidePanel
*/
Rectangle {
    id: root
    width: 640
    height: 480

    // LOG
    function log(msg){
        lblInfo.text += msg + "\r\n";
    }

    TextArea {
        id: lblInfo
        text: ""
        x: 0; y:0
        width: parent.width/2
        height: parent.height
    }
    Rectangle{
        id: rect
        color: 'green'
        x: parent.width/2
        y:0
        width: parent.width/2
        height: parent.height
        Text{text: '在我上面操作'}

        // 支持swipe检测的mousearea
        SwipeMouseArea {
            anchors.fill: parent;
            onClicked:         root.log('click');
            onDoubleClicked:   root.log('double click')
            onEntered:         root.log('enter')
            onExited:          root.log('exit')
            onCanceled:        root.log('cancel')
            onPressAndHold:    root.log('press and hold')
            onWheel:           root.log('wheel: ' + wheel.angleDelta.y)


            onSwipe:      showSwipeData('swipe');
            onReleased:   showSwipeData('release');

            function showSwipeData(event){
                if (swipeData.direction != 'None')
                    root.log(event + ": "
                               + swipeData.direction + ", "
                               + swipeData.distance + "d, "
                               + swipeData.dx + "x, "
                               + swipeData.dy + "y, "
                               + swipeData.angle + "'"
                               );
            }
        }
    }



}
