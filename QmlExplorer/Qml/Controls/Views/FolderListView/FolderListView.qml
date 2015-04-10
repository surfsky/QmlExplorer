import QtQuick 2.0
import Qt.labs.folderlistmodel 2.1


/**
QML目录导航列表
    /目录文件
    /文件过滤
    /递归
    /事件
    /高亮当前行
    /当前选项
    /目录切换动画
    /限制根目录

usage:
    FolderListView{
        onItemClicked:{
            console.debug(JSON.stringify(item));
        }
    }

author:
    surfsky.cnblogs.com
    2014-11
*/
ListView {
    id: lv
    width: 300
    height: 600

    //-----------------------------------------
    // public
    //-----------------------------------------
    property int rowHeight: 30                    // 行高
    property int fontSize: 20                     // 字体大小
    property color hightlightColor: "#d0d0d0"     // 高亮行背景色
    property var fileFilter : ["*.qml"]           // 文件过滤器
    property string initFolder: './'              // 初始目录
    property string rootFolder : '../'            // 限制根目录，不可再往上查找

    // 点击事件（包括文件和目录）
    signal itemClicked(var item);


    //-----------------------------------------
    // 模型
    //-----------------------------------------
    model: folderModel
    FolderListModel {
        id: folderModel
        nameFilters: lv.fileFilter
        folder: lv.initFolder
        showDirsFirst: true
        showDotAndDotDot: true
    }


    //-----------------------------------------
    // 场景切换动画
    //-----------------------------------------
    PropertyAnimation on x{id: aniForward; from: lv.width; to: 0}
    PropertyAnimation on x{id: aniBack; from: -lv.width; to: 0}



    //-----------------------------------------
    // 高亮行
    //-----------------------------------------
    highlightFollowsCurrentItem: false
    highlight: Rectangle {
        width: lv.width;
        height: lv.rowHeight
        color: hightlightColor
        y: lv.currentItem.y;
        Behavior on y { PropertyAnimation { properties: 'y'; duration: 300; easing.type: Easing.OutExpo } }
        //Behavior on y { SpringAnimation { spring: 2; damping: 0.1; duration:100 } }
    }


    //-----------------------------------------
    // 代理
    //-----------------------------------------
    delegate: Item{
        width: parent.width
        height: lv.rowHeight
        Text {
            text: fileName
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            font.pixelSize: lv.fontSize
            x: 5
        }
        Text {
            text: ">";
            visible:fileIsDir;
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right;
            anchors.rightMargin: 10
            font.pixelSize: lv.fontSize
        }
        Rectangle{
            width: parent.width
            height:1
            color: '#f0f0f0'
            y: parent.height - 1
            x: 0
        }

        MouseArea{
            anchors.fill:  parent
            onClicked: {
                parent.ListView.view.currentIndex = index

                // 触发节点点击事件
                var json = {
                    isDir: fileIsDir,
                    name: fileName,
                    path: filePath,
                    url: fileURL.toString(),
                    baseName: fileBaseName,
                    suffix: fileSuffix,
                    size: fileSize,
                    modified: fileModified,
                    accessed: fileAccessed,
                    folderUrl: getFolder(fileURL.toString())
                };
                console.debug(JSON.stringify(json));
                lv.itemClicked(json);

                // 目录处理
                if (fileIsDir){
                    // 限制根目录
                    if (lv.rootFolder != ''){
                        var folderURL = (fileURL + '/').toLowerCase();
                        var rootFolderURL = Qt.resolvedUrl(lv.rootFolder).toLowerCase();
                        if (rootFolderURL.indexOf(folderURL) != -1){
                            console.log('limit root: ' + rootFolderURL);
                            return;
                        }
                    }
                    changeFolder(json.name, json.url);
                }
            }

            // 获取文件所在的目录
            function getFolder(filePath)
            {
                var n = filePath.lastIndexOf('/');
                var folder = filePath.substr(0, n+1);
                return folder;
            }

            // 更改目录（修改model并启动相应的动画）
            function changeFolder(folderName, folderURL){
                //folderModel.showDotAndDotDot = folderURL!=rootFolderURL;  // （无效）
                folderModel.folder = folderURL;
                if (folderName == '..')     aniBack.start();
                else if (folderName == '.') ;
                else                        aniForward.start();
            }
        }
    }


}
