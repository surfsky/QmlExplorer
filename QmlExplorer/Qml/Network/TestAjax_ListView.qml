import QtQuick 2.0
import "../../js/ajax.js" as Ajax
import "../Controls/Views/ImageView"


/**
ajax 获取json数据示例
获取appstore某个app的信息
*/
Column {
    width: 420
    height: 800
    spacing: 10


    //-------------------------------------
    // APP 基础信息面板
    //-------------------------------------
    Rectangle{
        id: panelInfo
        width: parent.width-10
        height: 150
        y: 10
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 5
        gradient: Gradient{
            GradientStop{position: 0.0; color:'#f0f0f0'}
            GradientStop{position: 1.0; color:'#d0d0d0'}
        }

        Row{
            width: parent.width - 10
            height: parent.height - 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            ImageWithLoading{
                id: img;
                anchors.verticalCenter: parent.verticalCenter
            }
            Column{
                width: parent.width - img.width - 20
                height: parent.height
                anchors.topMargin: 10
                spacing: 10
                Text{id: txtName; text:' '; font.bold: true}
                Text{id: txtVersion; text:' '}
                Text{
                    id: txtDescription;
                    text:' ';
                    width: parent.width - 10
                    height:50
                    wrapMode: TextEdit.WrapAnywhere;
                    elide: Text.ElideMiddle
                    font.pixelSize: 12
                    lineHeight: 1.1
                }
            }
        }
    }

    //-------------------------------------
    // APP 缩略图列表
    //-------------------------------------
    ListView{
        id: lvImage
        anchors.horizontalCenter: parent.horizontalCenter
        width: 420
        height: 600
        clip: true
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        //cacheBuffer: 1  // 缓存区域高度、宽度、元素个数？

        delegate: Item{
            width: 420
            height: 600
            ImageWithLoading{
                anchors.centerIn: parent
                source: modelData;
                width: 400
                height: 600
                cache: true
            }
        }

        // 页面指示器
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            spacing: 20
            z:2
            Repeater {
                id: rpt
                opacity: 0.8
                Rectangle {
                    width: 5; height: 5
                    radius: 3
                    color: lvImage.currentIndex == index ? "grey" : "white"
                    MouseArea {
                        width: 20; height: 20
                        anchors.centerIn: parent
                        onClicked: lvImage.currentIndex = index
                    }
                }
            }
        }
    }

    //-------------------------------------
    // 获取APP数据
    //-------------------------------------
    Component.onCompleted: {
        var url = 'https://itunes.apple.com/cn/lookup?id=578875618';
        Ajax.get(url, function(result, json){
            console.log(result);
            var d = json.results[0];
            img.source = d.artworkUrl60;
            txtName.text = d.trackName
            txtVersion.text = d.artistName + "  " + d.version;
            txtDescription.text = d.description;
            lvImage.model = d.screenshotUrls;
            rpt.model = d.screenshotUrls.length;
            //model.append(d.screenshotUrls);  // 这个方法有问题，模型append一个纯数组有问题
        });
    }

}
