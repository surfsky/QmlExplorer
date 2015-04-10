import QtQuick 2.0
import "common.js" as Common


/**
js文件调用测试
- 注意导入的js必须as声明，且用用大写开头，否则会报错：Invalid import qualifier ID
- qml js 中不支持定时器，原有的setTimeOut() 和 clearTimeOut() 可用 Timer 组件实现
- qml js 不支持闭包。如何迁移那些三方类库得试验一下。
*/
Rectangle{
    width: 600
    height: 400
    Text {
        width: 200
        height: 100
        text: 'js 文件调用测试，请查看log'
    }

    // JS数组
    property var a : ['1','2','3','4','5'];


    // QtObject要想放到数组中去，不能简单用[]，会编译错误，估计编译器是认为缺少父组件。
    /*property var b: [
        GradientStop { position: 0.0; color: "green" },
        GradientStop { position: 0.6; color: "yellow" },
        GradientStop { position: 1.0; color: "red" }
    ]*/


    // 用数组容纳id是没有问题的
    property var c: [stop1, stop2, stop3];
    GradientStop { id: stop1; position: 0.0; color: "green" }
    GradientStop { id: stop2; position: 0.6; color: "yellow" }
    GradientStop { id: stop3; position: 1.0; color: "red" }


    // 或者用list<xxx>来容纳，这里[]行得通
    // list容纳的是QML对象，不能容纳基础数据类型
    // list一旦创建，无法增加删除，只能重新指定一个新的list
    // 请查看帮助 list QML Basic Type
    // 具体示例可看TestList, ColorGradientPicker
    property list<GradientStop> d: [
        GradientStop { position: 0.0; color: "green" },
        GradientStop { position: 0.6; color: "yellow" },
        GradientStop { position: 1.0; color: "red" }
    ]

    Component.onCompleted: {
        Common.array.push("a");
        Common.array.push("b");
        Common.array.push("c");
        console.log(Common.array.pop());
        console.log(Common.array.pop());
        console.log(Common.array.pop());

        // a
        console.log('c=' + a);
        a[a.length] = '999';
        console.log(a);
        a.push('6');
        console.log(a);
        a.remove(2);
        console.log(a);

        // c
        console.log('e=' + c);
        c.push('e');
        console.log(c);
        c.remove(2);
        console.log(c);

        // d(fail)
        // list一旦创建，无法增加删除，只能重新指定一个新的list
        console.log('d=' + d);
        console.log(d.length);
        d[d.length] = stop1;   // 无效，不报错
        console.log(d.length);
        d.append(stop1);       // 报错，无此方法
        console.log(d);
        d.remove(2);
        console.log(d);
    }
}

