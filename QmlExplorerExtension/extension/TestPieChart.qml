import QtQuick 2.0
import Charts 1.0
import QtQuick.Controls 1.1

Column {
    width: 640
    height: 480
    spacing: 10
    x: 10
    y: 10

    // 自定义组件，在main.cpp中注册
    PieChart{
        width: 100
        height: 100
        name: 'TestPieChart'
        color: 'red'
    }

    // 自定义组件，在main.cpp中注册
    GradientEx{
        width: 100
        height: 100
        type: 'conical'
    }


}
