import QtQuick 2.3
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import "../controls/Tip"

Grid
{
    id: root
    width: 640
    height: 480
    columns: 2
    spacing: 30



    // 原始图
    Text{text: "raw"}
    Cell{}

    // Matrix4x4
    Text{text: 'matrix transform'}
    Cell {
        transform: Matrix4x4 {
            property real a: Math.PI * 3 / 4
            matrix: Qt.matrix4x4(Math.cos(a), -Math.sin(a), 0, 0,
                                 Math.sin(a),  Math.cos(a), 0, 0,
                                 0,           0,            1, 0,
                                 0,           0,            0, 1)
        }
    }

    // 平移
    Text{text: "translate"}
    Cell{
        transform: Translate {x: 20 }
    }

    // 放缩
    Text{text: "scale"}
    Cell{
        //transform: Scale     {origin.x: 20; origin.y: 20; xScale: 3}
        transform: Scale     {xScale: 3}
    }

    // 旋转
    Text{text: "rotate"}
    Cell{
        transform: Rotation  {angle: 30 }
    }
    Text{text: "rotate + transformOrigin（没效果）"}
    Cell{
        transform: Rotation  {angle: 30 }
        transformOrigin:Item.Center   // 旋转中心点
    }
    Text{text: "rotate + origin(如何设置中心点为自己）)"}
    Cell{
        transform: Rotation  {origin.x:x+width/2; origin.y:y+width/2; angle: 30 }
    }

    // 旋转+平移
    Text{text: "rotate + translate"}
    Cell{
        transform: [
            Translate {x: 20 },
            Rotation  {origin.x: 20; origin.y: 20; angle: 30 }
        ]
    }

    // 完全用js代码设置变形
    Button{
        text: 'go'
        width: 100
        onClicked: {
            cell2.scale += 0.2;
            cell2.x += 100;
            cell2.rotation += 45;
        }
    }
    Cell{id: cell2}

}


