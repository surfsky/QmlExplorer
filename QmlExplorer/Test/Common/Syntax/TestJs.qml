import QtQuick 2.0
import QtQuick.Controls 1.2



Column{
    width: 600
    height: 300
    spacing: 10

    function getText(){
        return "hello world"
    }

    Button{
        text: 'Go'
        onClicked: lblInfo.text = getText();
    }


    Text {
        id: lblInfo
        text: '
    js语法、调用等，请查看/js/相关目录示例
    js文件调用注意:
    - 注意导入的js必须as声明，且用用大写开头，否则会报错：Invalid import qualifier ID
    - qml js 中不支持定时器，原有的setTimeOut() 和 clearTimeOut() 可用 Timer 组件实现
    - qml js 不支持闭包。如何迁移那些三方类库得试验一下。

    '
    }
}

