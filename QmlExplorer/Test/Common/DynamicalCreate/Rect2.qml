import QtQuick 2.0
import QtQuick.Controls 1.2


/**
该代码直接在qmlsecne中跑会失败，无法删除自身
但将该对象放到其他文件中去，删除自身正常
*/
Rectangle {
    id: root
    width: 200
    height: 100
    color: 'red'
    Component.onCompleted:   console.log('rect2 construct');
    Component.onDestruction: console.log('rect2 destruct');

    Row{
       spacing: 5
       Button{
           text: 'destory()'
           onClicked: root.destroy();
       }
    }
}

