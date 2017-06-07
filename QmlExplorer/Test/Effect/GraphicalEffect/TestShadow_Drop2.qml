import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../../Controls/"

Grid {
    width: 800
    height: 800
    spacing: 20
    columns: 3


    //-----------------------------------
    // 用Image做源
    //-----------------------------------
    Image {
        id: butterfly
        width: 100
        height: 100
        source: "../images/butterfly.png"
        smooth: true
    }

    // 右下角阴影（对图像有效）
    DropShadow {
        width: butterfly.width
        height: butterfly.height
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#80000000"
        source: butterfly
    }

    // 外发光（对图像有效）
    DropShadow {
        width: butterfly.width
        height: butterfly.height
        horizontalOffset: 0
        verticalOffset: 0
        radius: 32
        samples: 32
        color: "yellow"
        source: butterfly
    }


    //-----------------------------------
    // 用普通rectangle做源（失败）
    //-----------------------------------
    Rectangle{
        id: rect
        width: 100
        height: 100
        color: 'lightblue'
        radius: 10
    }

    // 这种方式无效，阴影的边缘太锐利（被切割了）
    DropShadow {
        source: rect
        width: source.width
        height: source.height
        horizontalOffset: 10
        verticalOffset: 10
        radius: 8.0
        samples: 16
        color: "#80000000"
    }


    // 外发光（对普通rect完全无效）
    DropShadow {
        width: source.width
        height: source.height
        horizontalOffset: 0
        verticalOffset: 0
        radius: 32
        samples: 32
        color: "yellow"
        source: rect
        //source: ShaderEffectSource {sourceItem: rect}
    }


    //-----------------------------------
    // 用普通rectangle再嵌套一个透明外框做源(ok)
    //-----------------------------------
    Rectangle{
        id: rect2
        width: 140
        height: 140
        color: 'transparent'
        Rectangle{
            width: 100
            height: 100
            color: 'lightblue'
            radius: 10
            anchors.centerIn: parent
        }
    }

    RectangleShadow{
        target : Rectangle{width: 100; height:100; radius:50}
    }

    RectangleWithShadow{
        width: 100
        height: 100
    }

    /*
    DropShadow {
        source: Rectangle{
            width: innerRect.width+40
            height: innerRect.height+40
            color: 'transparent'
            Rectangle{
                id: innerRect
                width: butterfly.width
                height: butterfly.height
                radius: 10
            }
        }
        width: source.width
        height: source.height
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8
        samples: 16
        color: "#80000000"
        spread: 0.0
    }
    */

    /*
    DropShadow {
        width: source.width
        height: source.height
        horizontalOffset: 10
        verticalOffset: 10
        radius: 8.0
        samples: 16
        color: "#80000000"
        source: rect2
        spread: 0.0
    }*/

    DropShadow {
        width: source.width
        height: source.height
        horizontalOffset: 0
        verticalOffset: 0
        radius: 32
        samples: 32
        color: "yellow"
        source: rect2
    }

    //-----------------------------------
    // 改造已有的item（复制原图，加上外框.ok）
    //-----------------------------------
    Rectangle{
        id: rect3
        width: clone.width + 40
        height: clone.height + 40
        color: 'transparent'
        DropShadow {
            id: clone
            anchors.centerIn: parent
            width: source.width
            height: source.height
            radius: 0
            samples: 0
            source: rect
        }
    }

    DropShadow {
        width: source.width
        height: source.height
        horizontalOffset: 10
        verticalOffset: 10
        radius: 8.0
        samples: 16
        color: "#80000000"
        spread: 0.0
        source: rect3
    }

    DropShadow {
        width: source.width
        height: source.height
        horizontalOffset: 0
        verticalOffset: 0
        radius: 32
        samples: 32
        color: "yellow"
        source: rect3
    }
}
