import QtQuick 2.0

/**
根据鼠标位置，动态设置鼠标光标
请将鼠标移动到中间矩形的边缘上测试
AUTHOR: surfsky.cnblogs.com 2015-03
*/
Rectangle {
    width: 600
    height: 600

    Rectangle {
        width: 400
        height: 400
        color: 'lightgreen'
        anchors.centerIn: parent
        MouseArea{
            id: area
            anchors.fill: parent
            hoverEnabled: true
            onPositionChanged: logPosition();

            function logPosition(){
                //console.log('(' + area.mouseX + ',' + mouseY + ')');
                var x = area.mouseX;
                var y = area.mouseY;

                // position cal
                var xText;
                var yText;
                if (x<=10)                    xText = 'Left';
                else if (x>10 && x<width-10)  xText = 'Middle';
                else if (x>width-10)          xText = 'Right';
                if (y<=10)                    yText = 'Top';
                else if (y>10 && y<height-10) yText = 'Center';
                else if (y>height-10)         yText = 'Bottom';

                // set cursor
                if      (xText=='Left'   && yText=='Top')    area.cursorShape = Qt.SizeFDiagCursor;
                else if (xText=='Left'   && yText=='Center') area.cursorShape = Qt.SizeHorCursor;
                else if (xText=='Left'   && yText=='Bottom') area.cursorShape = Qt.SizeBDiagCursor;
                else if (xText=='Middle' && yText=='Top')    area.cursorShape = Qt.SizeVerCursor;
                else if (xText=='Middle' && yText=='Center') area.cursorShape = Qt.ArrowCursor;
                else if (xText=='Middle' && yText=='Bottom') area.cursorShape = Qt.SizeVerCursor;
                else if (xText=='Right'  && yText=='Top')    area.cursorShape = Qt.SizeBDiagCursor;
                else if (xText=='Right'  && yText=='Center') area.cursorShape = Qt.SizeHorCursor;
                else if (xText=='Right'  && yText=='Bottom') area.cursorShape = Qt.SizeFDiagCursor;
            }
        }
    }
}

