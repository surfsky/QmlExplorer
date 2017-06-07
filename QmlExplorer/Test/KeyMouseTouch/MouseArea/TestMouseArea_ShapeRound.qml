import QtQuick 2.0


/**
测试圆形MouseArea
    计算鼠标位置与中心点的距离，判断是否出界
    clip只能处理矩形区域（Qt5.3），即不能裁剪非矩形区域UI，也不能裁剪非矩形区域外的消息

排除性能考虑，这才是最完美的解决方案：
    - item对象支持region（或由mask转换）
    - clip可根据region来裁剪
    - event也根据region来裁剪

官方不支持非矩形区域clip，我想估计是
    - 时间紧凑来不及做，先不实现（2012 Qt被Digia收购，重构得很厉害，Qt 5.x很精简）
    - 实现理论上并不困难，C++版本的setMask、QGesture本来就有的
    - 性能上考虑，矩形区域比非矩形区域的计算量可小多了
    - 担心打开潘多拉盒子，大量业余的非矩形区域计算，让qt重蹈flash覆辙
    - 建议官方出非正式解决方案，作为附属模块提供，给真正有需求的人用
*/
Rectangle {
    width: 600
    height: 600
    color: parentMouse.pressed ? 'green' : 'yellow'
    MouseArea{
        id: parentMouse
        anchors.fill: parent
    }

    Rectangle{
        id: rect
        anchors.centerIn: parent
        width:400; height:400;
        radius: 200
        color: mouse.pressed ? 'green' : 'blue'
        //clip: true
        MouseArea{
            id: mouse
            anchors.fill: parent
            property int radius : parent.width /2
            onPressed:{
                // 鼠标参数mouse.x/y已经是相对坐标
                // 计算鼠标位置与中心点的距离，判断是否出界
                var distance = Math.sqrt(
                      Math.pow(mouse.x - rect.radius, 2)
                    + Math.pow(mouse.y - rect.radius, 2)
                    );
                console.log("(" + mouse.x + ", " + mouse.y + ") " + distance);
                if (distance > radius)
                    mouse.accepted = false;
            }
        }
    }
}
