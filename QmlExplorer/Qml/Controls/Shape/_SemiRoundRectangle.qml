import QtQuick 2.0

/**
含圆角的矩形（可控制圆角的位置）
    可设置无圆角平滑边的位置

BUG
    无法处理border，还是用canvas绘制吧
*/
Rectangle {
    id: root
    width: 200
    height: 80
    color: 'lightgreen'
    radius: 20
    //border.width: 1
    //border.color: 'black'

    property string flatSide : 'left';
    onFlatSideChanged: {
        if (flatSide=='left')
        {
            rectFlat.width = root.width-root.radius;
            rectFlat.height= root.height;
            rectFlat.x = 0;
            rectFlat.y = 0;
        }
        else if (flatSide=='right')
        {
            rectFlat.width = root.width-root.radius;
            rectFlat.height= root.height;
            rectFlat.x = root.radius;
            rectFlat.y = 0;
        }
        else if (flatSide=='top')
        {
            rectFlat.width = root.width;
            rectFlat.height= root.height-root.radius;
            rectFlat.x = 0;
            rectFlat.y = 0;
        }
        else if (flatSide=='bottom')
        {
            rectFlat.width = root.width;
            rectFlat.height= root.height-root.radius;
            rectFlat.x = 0;
            rectFlat.y = root.radius;
        }
    }

    Rectangle{
        id: rectFlat
        color: root.color
        width: root.width-root.radius
        height: root.height
        x:0
        y:0
        //border.width: parent.border.width
        //border.color: parent.border.color
    }
}
