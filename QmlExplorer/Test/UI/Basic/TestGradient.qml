import QtQuick 2.5
import QtGraphicalEffects 1.0

Column {
    width: 480
    height: 640
    spacing: 10
    x: 10
    y: 10

    //----------------------------------------------------
    // Rectangle 内部的gradient
    //----------------------------------------------------
    Text{text: 'Rectangle默认的渐变（只能从上到下）。通过旋转（90度的倍数）实现其他方向的渐变'}
    Row{
        spacing: 10
        Rectangle {
            width: 80; height: 80
            gradient: Gradient {
                GradientStop { position: 0.0; color: "pink" }
                GradientStop { position: 1.0; color: "red" }
            }
        }
        Rectangle {
            width: 80; height: 80
            rotation: 90
            gradient: Gradient {
                GradientStop { position: 0.0; color: "pink" }
                GradientStop { position: 1.0; color: "red" }
            }
        }
        // 用Qt.lighter/darker方法，快速实现按钮效果
        Rectangle {
            width: 80; height: 80; radius:5
            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.lighter("lightsteelblue",1.25) }
                GradientStop { position: 0.67; color: Qt.darker("lightsteelblue",1.3) }
            }
        }
    }

    //----------------------------------------------------
    // 使用自己封装好的Gradient组件（用canvas实现）
    //----------------------------------------------------
    Text{text: '使用自己封装好的Gradient组件（用canvas实现）'}
    Loader{source: '../../Qml/Controls/Views/Gradients/TestGradients.qml'}


    //----------------------------------------------------
    // 使用Gradient组件
    // 早期版本无法实现旋转角度，现已修复 5.9
    //----------------------------------------------------
    Text{text: '用Gradient组件（QtGraphicalEffects 1.0）,可依赖指定item绘制渐变（有BUG）'}
    Row{
        spacing: 10

        // 线性渐变
        Rectangle {
            width: 80; height: 80
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(80, 80)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "green" }
                    GradientStop { position: 1.0; color: "yellow" }
                }
            }
        }

        // 圆形扩散渐变
        Rectangle {
            width: 80; height: 80
            RadialGradient {
                anchors.fill: parent
                angle: 45.0
                horizontalOffset: 0
                verticalOffset: 0
                horizontalRadius: 40
                verticalRadius: 100
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "green" }
                    GradientStop { position: 0.5; color: "yellow" }
                    GradientStop { position: 1.0; color: "red" }
                }
            }
        }

        // 圆锥形渐变
        Rectangle {
            width: 80; height: 80
            ConicalGradient {
                anchors.fill: parent
                angle: 45.0
                gradient: Gradient {
                    GradientStop { position: 0.000; color: Qt.rgba(1, 0, 0, 1) }
                    GradientStop { position: 0.167; color: Qt.rgba(1, 1, 0, 1) }
                    GradientStop { position: 0.333; color: Qt.rgba(0, 1, 0, 1) }
                    GradientStop { position: 0.500; color: Qt.rgba(0, 1, 1, 1) }
                    GradientStop { position: 0.667; color: Qt.rgba(0, 0, 1, 1) }
                    GradientStop { position: 0.833; color: Qt.rgba(1, 0, 1, 1) }
                    GradientStop { position: 1.000; color: Qt.rgba(1, 0, 0, 1) }
                  }
            }
        }

        // 依赖source组件内部绘制
        LinearGradient {
            width: 80; height:80
            source: Image { source: '../../Images/butterfly.PNG' }
            start: Qt.point(0, 0)
            end: Qt.point(80, 80)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "green" }
                GradientStop { position: 1.0; color: "yellow" }
            }
        }
    }




}
