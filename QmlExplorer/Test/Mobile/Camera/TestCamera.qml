import QtQuick 2.0
import QtMultimedia 5.4
import QtQuick.Controls 1.2


/**
摄像头测试
    /显示多个摄像头供选择
    /截图

性能
    速度凑合，但比directx要慢

扩展
    可结合Drawing/TestImage_SetRegion示例，设置照片的选取范围
    可结合QZXing库，做二维码检测
    可做复杂的图像处理
*/
Row {
    width: 860
    height: 500
    spacing: 10



    //------------------------------------------
    // 左侧控制区
    //------------------------------------------
    Column{
        width: 200
        height: 100
        spacing: 10

        // 可用的摄像头列表
        ListView {
            width: 200
            height: 100
            model: QtMultimedia.availableCameras
            highlight: Rectangle{width: parent.width; height: 20; color: 'lightgreen'}
            delegate: Text {
                width: parent.width
                height: 20
                text: modelData.displayName
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        camera.deviceId = modelData.deviceId
                        parent.ListView.view.currentIndex = index;
                    }
                }
            }
        }

        // 捕捉按钮
        Button{
            text: 'capture'
            width: 100
            onClicked: camera.imageCapture.capture()
        }
        // 聚焦按钮
        Button{
            width: 100
            text: if (camera.lockStatus == Camera.Unlocked) "Focus";
                  else if (camera.lockStatus == Camera.Searching) "Focusing"
                  else "Unlock"
            visible: camera.cameraStatus == Camera.ActiveStatus && camera.focus.isFocusModeSupported(Camera.FocusAuto)
            onClicked: (camera.lockStatus == Camera.Unlocked) ? camera.searchAndLock() : camera.unlock()
        }

        // 拍照后显示的图片
        Image {
            id: photoPreview
            width: parent.width
            fillMode: Image.PreserveAspectFit
        }
    }


    //------------------------------------------
    // 右侧视频输出区
    //------------------------------------------
    // 视频输出
    VideoOutput {
        source: camera
        width: 640
        height: 480
        focus : true
    }
    // 摄像机
    Camera {
        id: camera

        // 属性设置：模式、缩放
        captureMode: 'CaptureStillImage'
        digitalZoom: 1
        opticalZoom: 1

        // 特殊的子对象属性设置：白平衡、闪光灯、曝光度、聚焦
        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
        flash.mode: Camera.FlashRedEyeReduction
        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }
        focus {
            focusMode: Camera.FocusMacro
            focusPointMode: Camera.FocusAuto  //FocusPointCustom
            customFocusPoint: Qt.point(0.2, 0.2) // Focus relative to top-left corner
        }

        // 照片捕捉器
        imageCapture.onImageCaptured: {photoPreview.source = preview;}
    }
}
