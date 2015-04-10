import QtQuick 2.0
import QtQuick.Controls 1.2


/**
测试Flickable控件：
- 可拖拽轻拂子控件，使得视图在子项上滚动。
- 这种行为被设计用于显示大量的子项。例如LIstView和GridView
- 在基于触摸的用户界面，这种拖拽动作是经常和轻拂动作一起被实现，用户停止触摸视图后还一直在滚动。
- Flickable不会自动剪裁它的内容，如果不是用在全面的项，你应该考虑设置clip属性为true

使用
- 若 contentWidth > width就可以沿x方向拖动，y方向拖动同理
- 边界回弹设置 boundsBehavior
- 回弹效果设置 rebound

问题
    子物件被拉倒左侧外部去了，如何回弹回来？
*/
Flickable {
    // 容器大小（若 contentWidth > width就可以沿x方向拖动，y方向拖动同理）
    width: 300; height: 150
    contentX: 0; contentY:0
    contentWidth: width+100; contentHeight: 150
    clip: true  // 超出部分不显示
    //boundsBehavior: Flickable.DragOverBounds

    // 放开鼠标后回弹
    rebound: Transition {
        SpringAnimation{
            properties: "x,y"
            spring: 2; damping: 0.2
        }
        /*
        NumberAnimation {
            properties: "x,y"
            duration: 1000
            easing.type: Easing.OutBounce
        }*/
    }

    // 可拖拽的子元素
    Rectangle {
        width: 50; height: 50
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightsteelblue" }
            GradientStop { position: 1.0; color: "blue" }
        }
    }
}

