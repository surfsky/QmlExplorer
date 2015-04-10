import QtQuick 2.4


/*
Animator是直接在Qt Quick scene graph中操作的动画类型。
    高性能
        是 Qt 5.2 推出的，提供完全运行于渲染线程的动画
        即使主线程执行大量长期运行的计算也不会使界面阻塞卡顿。一般的动画和QML组件当UI线程阻塞的时候，动画渲染线程也阻塞。
        这个特点可以在文字跑马灯上看得很清楚。
            在芯承荣治的6120板卡上，使用QPainter绘制的跑马灯，当字体大于200时，会变得很卡
            而使用Animator，即使字体是全屏的，跑马灯依旧非常流畅。
    属性值
        这个类型的属性值在动画运行的时候，不会发生变化。只有当动画运行完毕，其属性才会更新。
    其他
        如果ParallelAnimation和SequentialAnimation的所有子动画都是Animator。那么它们会在可能的情况下，被当成一个Animator在场景中运行。
        Animator可用于过渡，但不可逆，既不能倒着播。
        Animator可以认为是接口，不能直接使用。其相应的实现有：
            XAnimator
            YAnimator
            ScaleAnimator
            OpacityAnimator
            RotationAnimator
            UniformAnimator

ps.
    简单的说，可以认为是高性能的动画，不会堵塞
    为什么不给传统的Animation添加一个属性，runInSceneGraph，以简化动画相关组件的数目?
    个人觉得Animation设计有点失控了，组件太多
*/
Rectangle{
    width: 800
    height: 600

    // XAnimator
    Rectangle {
        id: xmovingBox
        width: 50; height: 50
        color: "lightsteelblue"
        XAnimator {
            target: xmovingBox;
            from: 0;
            to: 100;
            duration: 2000
            running: true
        }
    }

    // YAnimator
    Rectangle {
        id: ymovingBox
        width: 50; height: 50
        color: "lightsteelblue"
        YAnimator {
            target: ymovingBox;
            from: 0;
            to: 100;
            duration: 2000
            running: true
        }
    }

    // ScaleAnimator
    Rectangle {
        id: mixBox
        x: 100; y: 100
        width: 50; height: 50
        ParallelAnimation {
            ColorAnimation {
                target: mixBox
                property: "color"
                from: "forestgreen"
                to: "lightsteelblue";
                duration: 1000
            }
            ScaleAnimator {
                target: mixBox
                from: 2
                to: 1
                duration: 1000
            }
            running: true
        }
    }

    Rectangle {
        id: rotatingBox
        x: 200; y:200
        width: 50; height: 50
        color: "lightsteelblue"
        RotationAnimator {
            target: rotatingBox;
            from: 0;
            to: 360;
            duration: 1000
            running: true
        }
    }

    // UniformAnimator, 类似PropertyAnimation
    ShaderEffect {
        id: shader
        x: 300; y:300
        width: 50; height: 50
        property variant t;
        UniformAnimator {
            target: shader
            uniform: "t"
            from: 0
            to: 1
            duration: 3000
            running: true
        }
        fragmentShader:
        "
            uniform lowp float t;
            varying highp vec2 qt_TexCoord0;
            void main() {
                lowp float c = qt_TexCoord0.y;
                gl_FragColor = vec4(0, 0, c * t, 1);
            }
        "
    }
}

