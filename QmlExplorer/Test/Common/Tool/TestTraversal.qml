/**
遍历子元素测试
注意： qml不支持for each循环，只能用下标访问
*/
import QtQuick 2.0
import QtQuick.Controls 1.2
import "../../../js/string.js" as StrHelp

Column {
    id: root
    width: 500; height:500
    x:0; y:0
    spacing: 10
    //color: 'white'
    //tag: 'root'

    Rectangle{
        id: rect
        width: 200; height:200
        x:100; y:100
        color: 'green'

        Rectangle{
            width: 100; height:100
            x:50; y:50
            color: 'yellow'
            Rectangle{
                width: 100; height:100
                x:50; y:50
                color: 'yellow'
            }
        }
        Rectangle{
            width: 100; height:100
            x:80; y:80
            color: 'green'
            opacity: 0.8
        }
    }

    Button{
        id: btn
        text: '遍历子元素'
        onClicked: {
            printChildren(root, 0);
            printRoot(btn);
            console.log(getRoot(btn));
        }
    }

    Button{
        id: btn2
        text: '删除子元素'
        onClicked: {
            //delChildren(rect);
            rect.children[0].destroy();
            printChildren(root, 0);
        }
    }

    // 遍历子元素
    function printChildren(parent, lvl)
    {
        var children = parent.children;
        var info = '{0} {1}, ({2}, {3}, {4}, {5}), {6}'.format(
                    '  '.repeat(lvl),
                    parent.toString(),
                    parent.x,
                    parent.y,
                    parent.width,
                    parent.height,
                    children.length
                    );
        console.log(info);
        for (var i = 0; i < children.length; i++)
        {
            printChildren(children[i], lvl+1);
        }
    }

    // 倒推查找根元素
    function getRoot(item)
    {
        if (item.parent != null)
            return getRoot(item.parent);
        else
            return item;
    }
    function printRoot(item)
    {
        var info = '{0}, ({1}, {2}, {3}, {4})'.format(
                    item.toString(),
                    item.x,
                    item.y,
                    item.width,
                    item.height
                    );
        console.log(info);
        if (item.parent != null)
            printRoot(item.parent);
    }

    function delChildren(item)
    {
        var childrens = item.children;
        if (children.length > 0)
            childrens.remove(0);
    }

}
