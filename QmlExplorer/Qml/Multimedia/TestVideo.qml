import QtQuick 2.0
import QtMultimedia 5.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

/**
视频播放测试
Video 可以播放avi文件（默认支持的格式不多）
Qt 的多媒体模块，实际上是个壳
    在windows平台上，它使用DirectShow。如果不能播放，可尝试安装LAV Filter
    在Linux平台上，它使用GStream
    在Andriod平台上，它使用MediaPlayer框架
完整的播放器请看qt示例程序 D:\Qt\Qt5.4.1\Examples\Qt-5.4\multimedia\video\qmlvideo
*/
Column{
    width: 800
    height: 600
    spacing: 10

    // 控制区
    Row{
        spacing: 10
        Button {
            text: 'open'
            onClicked: fileDialog.open();
        }
        Button {
            text: '||'
            onClicked: {
                if (text == '||'){
                    mediaplayer.pause();
                    text = '>';
                }
                else{
                    mediaplayer.play();
                    text = '||';
                }
            }
        }
    }

    // 文件对话框
    FileDialog {
        id: fileDialog
        nameFilters: ["Video files (*.avi)", "All files (*.*)"]
        onAccepted: {
            mediaplayer.source = fileUrl;
            mediaplayer.play();
        }
    }


    // 播放组件
    MediaPlayer {id: mediaplayer}
    VideoOutput {
        source: mediaplayer
        width: parent.width
        height: parent.height - 30
    }


}

