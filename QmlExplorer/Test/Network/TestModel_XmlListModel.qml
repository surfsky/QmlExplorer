import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.XmlListModel 2.0
import "../Controls/ImageView/"


/**
测试xml数据模型
可以直接访问网络数据，并提供解析方法
问题：如何控制xmllistmodel何时工作？没有enable属性？直接设置resouce属性为空？
*/
Column {
    width: 640
    height: 480
    spacing: 5

    //
    Text{text:'XmlListModel测试。Ajax方式原生DOM操作请查看TestAjax_XmlDOM.qml';height:20}
    Row{
        spacing: 5
        Button{text:'Load XML'; onClicked:cats.reload();}
        Text{id:txtStatus; text:'...';height:20; y:5}
        Text{id:txtProgress; text:'...';height:20; y:5}
    }
    Row{
        spacing: 5
        Button{text:'Read XML'; onClicked:txtInfo.text = cats.get(0).title;}
        Text{id:txtInfo; text:'...';height:20; y:5}
    }


    // model
    XmlListModel {
        id: cats
        source: "http://api.flickr.com/services/feeds/photos_public.gne?format=rss2&tags=Cat"
        query: "/rss/channel/item"
        namespaceDeclarations: "declare namespace media=\"http://search.yahoo.com/mrss/\";"
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "imagesource"; query: "media:thumbnail/@url/string()" }
        XmlRole { name: "credit"; query: "media:credit/string()" }

        // 进度展示
        onProgressChanged: {
            txtProgress.text = progress*100 + "%";  // 只有0%和100%。。。
        }
        onStatusChanged: {
            txtStatus.text = toStatusString(status);
        }
        function toStatusString(code){
            switch(code){
                case XmlListModel.Null: return 'nothing';
                case XmlListModel.Ready: return 'Ready';
                case XmlListModel.Loading: return 'Loading';
                case XmlListModel.Error: return 'Error';
            }
        }
    }


    //
    ListView {
        width: parent.width
        height: 400
        spacing: 5
        clip: true
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
