import QtQuick 2.2
import "Views/Tip"

/*
圆形提示组件
- 可设置半径：radius
- 可设置文本：text, textColor, textSize
- 可设置三态色彩：normal, hover, click
*/
Tip {
    id : root
    width: radius*2
    height: radius*2

    // radius
    radius: 20
    onRadiusChanged: {
        radius = radius;
        width = 2*radius;
        height = 2*radius;
    }
}
