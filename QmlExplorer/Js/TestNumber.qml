import QtQuick 2.0

/**
数值类型测试
其实也就是测试js的兼容性吧
*/
Column {
    width: 100
    height: 62
    spacing: 5

    Text{
        text: '数字的位数的精度控制'
    }
    Text{
        text: (2/3)
    }
    Text{
        text: (2/3).toFixed(2)
    }
    Text{
        text: (2/3).toPrecision(4)
    }
}
