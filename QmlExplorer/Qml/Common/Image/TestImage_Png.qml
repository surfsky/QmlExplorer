import QtQuick 2.0

/**
测试png透明效果
*/
Rectangle {
    width: 500
    height: 500
    color: 'white'

    Image{
        x: 50; y:50
        source: "test.png"
        opacity: 0.8
    }

    Image{
        x: 100; y:100
        source: "test.png"
        opacity: 0.8
    }

    Image{
        x: 150; y:150
        source: "test.png"
        opacity: 0.8
    }
}
