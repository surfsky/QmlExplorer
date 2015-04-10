import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.XmlListModel 2.0
import "../../../Controls/ImageView/"


/**
测试xml数据模型
可以直接访问网络数据，并提供解析方法
*/
Column {
    width: 640
    height: 480


    Text{text:'XmlListModel测试。XML原生DOM操作请查看/network/TestAjax_XmlDOM.qml'}

    XmlListModel {
        id: cats
        source: "http://api.flickr.com/services/feeds/photos_public.gne?format=rss2&tags=" + "Cat"
        query: "/rss/channel/item"
        namespaceDeclarations: "declare namespace media=\"http://search.yahoo.com/mrss/\";"
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "imagesource"; query: "media:thumbnail/@url/string()" }
        XmlRole { name: "credit"; query: "media:credit/string()" }
    }

    ListView {
        width: parent.width
        height: 400
        spacing: 5
        model:cats
        delegate: Row {
            spacing: 10
            ImageWithLoading{source:imagesource}
            Column{
                Text{text:title}
                Text{text:credit}
            }
        }
    }
}
