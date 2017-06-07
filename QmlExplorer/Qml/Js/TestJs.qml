import QtQuick 2.0
import QtQuick.Controls 1.2
import "common.js" as Common

Rectangle{
    id: root
    width: 600
    height: 400
    Text {
        width: 200
        height: 100
        text: 'js文件调用注意:
- 注意导入的js必须as声明，且用用大写开头，否则会报错：Invalid import qualifier ID
- qml js 中不支持定时器，原有的setTimeOut() 和 clearTimeOut() 可用 Timer 组件实现
- qml js 不支持闭包。如何迁移那些三方类库得试验一下。'
    }

    Column{
        anchors.centerIn: parent
        Button{
            text: 'dialog'
            onClicked: {
                Common.alert('title', 'alert alert alert alert', root,
                             function(){console.log('ok');});
            }
        }
    }

}
