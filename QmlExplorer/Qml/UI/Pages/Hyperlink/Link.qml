import QtQuick 2.0
import "../../../../Js/string.js" as String

/**
超链接组件（未完成）
    /如果目标是打电话等，调用外部程序
    /如果目标是qml，用loader调用并全屏
    如果目标是web，用webview调用并全屏
bug
    老的qml元素死活删除不掉
*/
Text{
    id: link
    //---------------------------------------
    // 公共属性
    //---------------------------------------
    text: 'link'
    color: 'blue'
    font.underline: true
    property string url: '../Page1.qml'
    property Item container: null;
    signal clicked(var mouse);


    //---------------------------------------
    //---------------------------------------
    MouseArea{
        anchors.fill: parent
        onClicked: {
            var u = url.toLowerCase();
            if (u.startsWith('tel:') || u.startsWith('sms:') || u.startsWith('mailto:'))
                Qt.openUrlExternally(u);
            else
            {
                var root = (link.container == null)
                    ? getRoot(link)
                    : link.container
                    ;
                clearChildren(root);

                // 加载
                var txt = 'import QtQuick 2.0; Loader{}'
                var loader = Qt.createQmlObject(txt, root, '');
                loader.parent = root;
                loader.anchors.fill = parent;
                loader.source = url;

                //
                link.clicked(mouse);
            }
        }
    }


    //---------------------------------------
    // 私有方法
    //---------------------------------------
    // 获取qml根元素
    function getRoot(item)
    {
        return (item.parent !== null) ? getRoot(item.parent) : item;
    }

    // 删除子节点（怎么都删除不掉）
    function clearChildren(item)
    {
        var len = item.children.length;
        for (var i=len-1; i>=0; i--)
        {
            try{
                console.log("remove " + item.children[i]);
                item.children[i].destory();
                item.children.length--;
            }catch(e){
                console.log('remove fail' + i);
            }
        }
    }
}
