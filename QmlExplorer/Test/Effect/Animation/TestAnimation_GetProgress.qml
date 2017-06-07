import QtQuick 2.0


/**
以下示例演示了如何获取当前动画的进度
    - Animation对象本身并没有提供任何进度信息
    - 但Animation针对的是某个属性，那么属性的当前值就可以反映了动画的进度
*/
Rectangle {
    width: 800
    height: 600

    // 进度指示器
    Text{
        id: txt
        text: roundx(rect.x/600*100, 2) + '%'
        // 四舍五入到小数点某个位数
        function roundx(x, num){
            return Math.round(x * Math.pow(10, num)) / Math.pow(10, num) ;
        }
    }

    // 动画对象
    Rectangle{
        id: rect
        width: 100
        height: 100
        color: 'lightblue'
        y: 100

        NumberAnimation on x {
            duration: 5000
            from: 0
            to: 600
            loops: Animation.Infinite
        }
    }

}

