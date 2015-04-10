import QtQuick 2.2
import "Views/Tip"

/*
正方形
- 可设置边长： size
- 可设置文本：text, textColor, textSize
- 可设置三态色彩：normal, hover, click
*/
Tip {
    id: root
    width: size
    height: size
    radius: 0

    property int size: 40
    onSizeChanged: {
        width = size;
        height = size;
    }
}
