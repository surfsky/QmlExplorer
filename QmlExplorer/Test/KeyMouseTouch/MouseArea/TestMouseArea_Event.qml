/**
测试MouseArea事件，更复杂的手势请看TestGesture示例（如swipe）
*/
import QtQuick 2.0
import QtQuick.Controls 1.1
Rectangle {
    id: root
    width: 640
    height: 480

    // LOG
    function log(msg){
        if (lblInfo.lineCount > 50)
            lblInfo.text = '';
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

        MouseArea {
            anchors.fill: parent;
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked:         root.log('click');
            onDoubleClicked:   root.log('double click')
            onEntered:         root.log('enter')
            onExited:          root.log('exit')
            onCanceled:        root.log('cancel')
            onPressAndHold:    root.log('press and hold')
            onPositionChanged: root.log('position change: ' + mouseX + ',' + mouseY)
            onWheel:           root.log('wheel: ' + wheel.angleDelta.y)
            onPressed:         root.log('pressed: ' + mouseX + ',' + mouseY + ',' + mouse.buttons);
            onReleased:        root.log('released: ' + mouseX + ',' + mouseY);
        }
    }



}
