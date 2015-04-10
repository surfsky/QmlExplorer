import QtQuick 2.0

/**
含swipe手势动作的MouseArea

*/
MouseArea {
    id: mouseArea
    anchors.fill: parent;

    // 滑动信号和数据
    property var swipeData : {direction: 'None'}
    signal swipe(var swipeData);

    // 私有属性
    property var startPt;
    property int distanceThreadhold : 5
    property bool swipeStart : false;

    // Swipe手势判断
    onPressed: {
        swipeData = {direction: 'None'};
        startPt = {x:mouseX, y:mouseY};
        swipeStart = false;
    }
    onPositionChanged: {
        var pt2 = {x:mouseX, y:mouseY};
        var distance = calcDistance(startPt, pt2);
        if (swipeStart || distance > distanceThreadhold)
        {
            swipeStart = true;
            var angle = calcAngle(startPt, pt2);
            var direction = angleToDirection(angle);
            if (swipeStart){
                swipeData = {
                    direction: direction,
                    dx: mouseX-startPt.x,
                    dy: mouseY-startPt.y,
                    distance: distance,
                    angle: Math.round(angle)
                };
               swipe(swipeData);
            }
        }
    }


    //---------------------------------------
    // 私有方法
    //---------------------------------------
    // 计算两点距离
    function calcDistance(pt1, pt2)
    {
        return Math.round(Math.sqrt(
             Math.pow(pt2.x - pt1.x, 2)
           + Math.pow(pt2.y - pt1.y, 2)
           ));
    }

    // 根据屏幕上的两个点计算角度（x正方向为0）
    function calcAngle(pt1, pt2)
    {
        var angle;
        if (pt2.x == pt1.x)
        {
            if (pt2.y > pt1.y)  angle = 90;
            if (pt2.y <= pt1.y) angle = 270;
        }
        if (pt2.y == pt1.y)
        {
            if (pt2.x >= pt1.x) angle = 0;
            if (pt2.x < pt1.x)  angle = 180;
        }
        else
        {
            angle = (180/Math.PI) * Math.atan((pt2.y - pt1.y)/(pt2.x - pt1.x));
            // 2、3象限调整
            if (pt2.x < pt1.x) angle += 180;
            if (angle < 0)     angle += 360;
        }

        return angle;
    }

    // 将角度转化为方位（x正方向为0）
    function angleToDirection(angle)
    {
        angle = angle % 360;
        if      (angle > 0 && angle <= 22.5)      return 'Right';
        else if (angle > 22.5 && angle <= 67.5)   return 'BottomRight';
        else if (angle > 67.5 && angle <= 112.5)  return 'Bottom';
        else if (angle > 112.5 && angle <= 157.5) return 'BottomLeft';
        else if (angle > 157.5 && angle <= 202.5) return 'Left';
        else if (angle > 202.5 && angle <= 247.5) return 'TopLeft';
        else if (angle > 247.5 && angle <= 292.5) return 'Top';
        else if (angle > 292.5 && angle <= 337.5) return 'TopRight';
        else return 'Right';
    }
}
