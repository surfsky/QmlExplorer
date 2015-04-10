import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtMultimedia 5.3


/**
视频扑捉测试
花屏(sansung 939)。。。
*/
Item {
    anchors.fill: parent


    //
    /*
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // 录像输出窗口
        VideoOutput {
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: camera
            autoOrientation: true
        }

        // 拍照控制按钮
        RowLayout {
            Layout.fillWidth: true
            Button {
                text: "Record"
                visible: camera.videoRecorder.recorderStatus == CameraRecorder.LoadedStatus
                onClicked: camera.videoRecorder.record()
            }
            Button {
                text: "Stop"
                visible: camera.videoRecorder.recorderStatus == CameraRecorder.RecordingStatus
                onClicked: {
                    camera.videoRecorder.stop()
                    previewVideo.visible = true
                }
            }
            Item {
                Layout.fillWidth: true
            }
            Button {
                text: if (camera.lockStatus == Camera.Unlocked) "Focus";
                      else if (camera.lockStatus == Camera.Searching) "Focusing"
                      else "Unlock"
                visible: camera.cameraStatus == Camera.ActiveStatus && camera.focus.isFocusModeSupported(Camera.FocusAuto)
                onClicked: (camera.lockStatus == Camera.Unlocked) ? camera.searchAndLock() : camera.unlock()
            }
        }
    }
    */

    // 相机
    Camera {
        id: camera
        captureMode: Camera.CaptureVideo
    }


    // 媒体播放器
    MediaPlayer {
        id: mediaPlayer
        autoPlay: true
        source: previewVideo.visible ? camera.videoRecorder.actualLocation : ""
        onStatusChanged: {
            if (status == MediaPlayer.EndOfMedia)
                previewVideo.visible = false
        }
    }

    // 媒体播放器的输出
    VideoOutput {
        id : previewVideo
        anchors.fill : parent
        visible: false
        source: mediaPlayer

        Rectangle {
            anchors.fill: parent
            color: "black"
            z: -1
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                camera.start()
                previewVideo.visible = false
            }
        }
    }
}
