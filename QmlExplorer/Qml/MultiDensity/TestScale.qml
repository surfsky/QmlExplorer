import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2

/**
屏幕自动拉伸适配方案
    逻辑
        高度满屏，宽度可同比拉伸
        居中显示，两侧显示黑色
    效果
        图片控件都没啥问题
        放大：文字用pointSize很清晰，用pixelSize很模糊
        缩小：文字没法看
    适合游戏:
        游戏一般是按照像素来设计的，物体的位置和距离是固定死像素的。
        游戏一般全屏进行，其全屏模式有：
            按同比拉伸，高度填满，宽度两侧留白(黑）
            高宽都填满，高宽放缩不同比例
    结论
        放大可接受；文字要用pointSize来限制字号。
        适合固定分辨率的APP（如游戏）
        可设计一套中等分辨率的图片，拉伸即可适配高分辨率屏幕
        就现在的手机而言，设计两套分辨率图片基本上就够用了

2015-01 surfsky.cnblogs.com
*/
Rectangle{
    id: root
    width: 800
    height: 600
    color: 'black'

    // 原始UI
    Rectangle{
        id: rect
        width: 240
        height: 320
        Column{
            spacing: 5
            Text {text: 'raw size: ' + rect.width + " x " + rect.height; font.pointSize: 10}
            Text {text: 'raw size: ' + rect.width + " x " + rect.height; font.pixelSize: 10}
            Text {text: 'target size: ' + root.width + " x " + root.height}
            Text {text: 'scale rate: ' + root.height / rect.height}
            Rectangle{width: 100; height:100; radius: 20; color: 'lightblue'}
            TextField{text: 'hello world'; focus: true}
            Image {source: "./res/bug.png"; width: 100; height: 100}
        }
    }


    // 拉伸处理
    Scale {id: scaler; xScale: 1; yScale: 1}
    onWidthChanged: scaleTarget(rect);
    onHeightChanged: scaleTarget(rect);
    Component.onCompleted: scaleTarget(rect);
    function scaleTarget(target){
        target.transformOrigin = Item.Top;
        target.y = 0;

        var rateX = root.height / rect.height;
        scaler.xScale = rateX;
        scaler.yScale = rateX;
        target.transform = scaler;
        target.x = (root.width - target.width*scaler.xScale)/2;
        console.log("rate=" + rateX + ", x=" + target.x);
    }
}
