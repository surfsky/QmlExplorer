import QtQuick 2.0
import QtQuick.Controls 1.1

/**
测试属性语法
属性名称
    - 属性必须用小写字母打头
    - 不能使用保留关键字
    - 一旦设置属性，就自动增加了相应的changed事件

属性类别
    - QML基本类型中的枚举类型: int, bool, double, real, string, url, color, date, variant
    - 任何QML对象类型都可以作为property类型，如：Item, Rectangle, TouchPoint
    - var 是通用的类型，可保留列表和对象
    - 不支持匿名对象，如 {x:1; y:0}

修饰符
    readonly
    default
    alias

请参考：http://blog.csdn.net/chenlong12580/article/details/8652597
*/
Column {
    id: root
    width: 400
    height: 300
    spacing: 10


    //--------------------------------
    // 属性类别
    //--------------------------------
    // js基础数据类型：数字、字符串、布尔
    property int  someInt: 2
    property bool someBool : true
    property double  someNumber: 1.5
    property real someReal: 1.2
    property string someString : 'abc'

    // qt扩展数据类型
    property point somePoint : Qt.point(0, 10)
    property size someSize : Qt.size(10, 10)
    property rect someRect : Qt.rect(0, 0, 100, 100);
    property url someUrl: "http://www.baidu.com"
    property date someDate: '2014-10-01'
    property font someFont: Qt.font('font.family: "Helvetica"; font.pointSize: 13; font.bold: true');  //// 是这样用么？
    property color someColor: Qt.rgba(1, 1, 1, 1); //Qt.hsla(), Qt.darker(), Qt.lighter() or Qt.tint()
    property vector2d someV2 : Qt.vector2d(100, 100);
    property vector3d someV3 : Qt.vector3d(100, 100, 100);
    property vector4d someV4 : Qt.vector4d(100, 100, 100, 100);
    property quaternion someQuaternion : Qt.quaternion(2.0, 0, 0, 0); // 变化矩阵
    property matrix4x4 someM4 : Qt.matrix4x4(1, 1, 1, 1,
                                             2, 2, 2, 2,
                                             3, 3, 3, 3,
                                             4, 4, 4, 4);

    // 任何QML对象类型
    property var someObject : Rectangle {width:100; height:100; color:'red'}
    property var someVec4: QtObject{
        property int p1: 1
        property int p2: 2
        property int p3: 3
        property int p4: 4
    }

    // 数组
    property var someArray : new Array();
    property var someList : [1, 2, "three", "four"]
    property list<Rectangle> rects :[
        Rectangle {color: 'red'},
        Rectangle {color: 'blue'}
    ]

    // JSON
    property var someJson: {x:5; y:1}     // 编译可通过，但无法访问子属性(someJson.x)
    property var someJson2: [{x:5, y:1}]  // 套一个数组试试ok: someJson2[0].x


    //--------------------------------
    // 属性修饰符
    //--------------------------------
    // 别名
    property alias text: text1.text

    // 只读
    readonly property int degree: 0

    // 缺省属性
    //default property list<Item> rects;   // 编译错误
    //default property list rects :[       // 编译错误
    //        Rectangle {color: 'red'},
    //        Rectangle {color: 'blue'}
    //    ]
    /*
    缺省属性一般用于放置子元素
    如Item里面可以容纳任何Item，事实上是用default property list<Object> data 来定义的
    用了缺省属性后，就可以直接直接将子元素放到父元素内，而不用写属性名称
        TestProperty{
            Rectangle{....}
            Item{....}
        }
    等价于
        TestProperty{
            content: [
                Rectangle{....},
                Item{....}
            ]
        }
    可参考TabWidget官方示例
    */
    default property alias content: container.children

    // 如何使用组合属性？
    // 弄成：border.width, border.color
    property var borderWidth: 2
    property var borderColor: 'green'




    //--------------------------------
    // 控制区
    //--------------------------------
    Button{
        text: 'get text property'
        onClicked: input1.text = root.text
    }
    Button{
        text: 'set text property'
        onClicked: root.text = input1.text;
    }

    Button{
        text: 'get json property(fail)'
        onClicked: {
            console.log(someJson.toString());  // 输出1
            root.text = someJson.x;
        }
    }

    Button{
        text: 'get array json property(ok)'
        onClicked: {
            var o = someJson2[0];
            root.text = o.x;
        }
    }

    Button{
        text: 'get vec4 property(ok。但没有智能提示)'
        onClicked: {
            root.text = someVec4.p4;
        }
    }

    //--------------------------------
    // 输出区
    //--------------------------------
    Text{id: text1; text: 'hello world'; color: 'red'}
    TextInput{id: input1; width: 200}
    Item{id: container; width: parent.width; height: 50}
}
