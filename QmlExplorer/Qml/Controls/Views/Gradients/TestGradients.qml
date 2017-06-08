import QtQuick 2.0


/**
测试自定义的渐变组件（用canvas绘制）
注：官方的Gradient组件
    import QtGraphicalEffects 1.0
    基于shader绘制
    可以作用于任何对象，如在图像内部绘制渐变
    但有bug（如方向不能控制）qt5.4
注2:
    5.8 已经可以控制渐变方向了。该代码仅供参考。
*/
Row{
    spacing: 10

    GradientLinear{
        width: 80; height: 80
        start: Qt.point(0, 0)
        end: Qt.point(width, height)
        gradient: Gradient{
            GradientStop { position: 0.0; color: "green" }
            GradientStop { position: 0.4; color: "yellow" }
            GradientStop { position: 0.8; color: "red" }
        }
    }

    GradientRadial{
        width: 80; height: 80
        gradient: Gradient{
            GradientStop { position: 0.0; color: "green" }
            GradientStop { position: 0.4; color: "yellow" }
            GradientStop { position: 0.8; color: "red" }
        }
    }

    GradientConical{
        width: 80; height: 80
        gradient: Gradient{
            GradientStop { position: 0.0; color: "green" }
            GradientStop { position: 0.5; color: "yellow" }
            GradientStop { position: 1.0; color: "green" }
        }
    }
}
