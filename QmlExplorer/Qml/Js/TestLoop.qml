import QtQuick 2.0

/**
测试js 循环语法，foreach语法有点怪异，要小心
*/
Rectangle {
    width: 100
    height: 62

    property list<Rectangle> rects :[
        Rectangle {color: 'red'},
        Rectangle {color: 'blue'}
    ]

    Component.onCompleted: {
        // 用下标方式遍历
        for (var i=0; i<rects.length; i++)
        {
            var rect = rects[i];
            console.log(rect.color);
        }

        // 注意用这种方式获取的是key。为了避免和其他语言混淆，还是用下标遍历方式吧。
        for (var key in rects)
        {
            var rect = rects[key];
            console.log(rect.color);
        }
    }
}
