import QtQuick 2.0
import Qt.labs.folderlistmodel 2.1


/**
QML目录导航列表
    /目录文件
    /递归
    /事件
    /高亮当前行
    /当前选项
    /目录切换动画
    限制根目录
本文件不做更新，最新版本请查看：QmlFileList
*/
ListView {
    id: lv
    width: 200
    height: 600

    //-----------------------------------------
    // public
    //-----------------------------------------
    property int rowHeight: 30
    property int fontSize: 20
    property color hightlightColor: "lightgreen"
    property string folder: './'
    property var fileFilter : ["*.qml"]

    signal itemClicked(var item);



    //-----------------------------------------
    // private
    //-----------------------------------------
    property string _direction : 'forward';


    //-----------------------------------------
    // 模型
    //-----------------------------------------
    model: folderModel
    FolderListModel {
        id: folderModel
        nameFilters: lv.fileFilter
        folder: lv.folder
        showDirsFirst: true
        showDotAndDotDot: true
    }


    //-----------------------------------------
    // 场景切换动画
    //-----------------------------------------
    onModelChanged: {
        console.debug('model changed');
        if (lv._direction=='forward')       aniForward.start();
        else if (lv._direction=='backward') aniBack.start();
    }
    PropertyAnimation on x{id: aniForward; from: lv.width; to: 0}
    PropertyAnimation on x{id: aniBack; from: -lv.width; to: 0}


    //-----------------------------------------
    // 高亮代理
    //-----------------------------------------
    highlight: Rectangle {
        width: lv.width;
        height: lv.rowHeight
        color: hightlightColor
        y: lv.currentItem.y;
        //Behavior on y { PropertyAnimation { properties: 'y'; duration: 300; easing.type: Easing.OutExpo } }  // 有问题，哪里逻辑重复了
        Behavior on y { SpringAnimation { spring: 2; damping: 0.1; duration:100 } }
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
            //onPressed: parent.color = '#f0f0f0f0';
            //onExited: parent.color = 'transparent';
            onClicked: {
                parent.ListView.view.currentIndex = index
                if (fileName == '..')     lv._direction = 'backward';
                else if (fileName == '.') lv._direction = 'reflesh';
                else                      lv._direction = 'forward';
                if (fileIsDir){
                    // 如果是目录，则更改model
                    console.debug(fileURL);
                    folderModel.folder = fileURL;
                    lv.onModelChanged(); // 强行触发modelchanged事件
                }
                else{
                    // 如果是节点，则触发节点点击事件
                    var json = {
                        name: fileName,
                        path: filePath,
                        url: fileURL.toString(),
                        baseName: fileBaseName,
                        suffix: fileSuffix,
                        size: fileSize,
                        modified: fileModified,
                        accessed: fileAccessed,
                        isDir: fileIsDir,
                        urlFolder: getFolder(fileURL.toString())
                    };
                    console.debug(JSON.stringify(json));
                    lv.itemClicked(json);
                }
            }
            // 获取文件所在的目录
            function getFolder(filePath)
            {
                var n = filePath.lastIndexOf('/');
                var folder = filePath.substr(0, n+1);
                return folder;
            }
        }
    }


}
