import QtQuick 2.0
import QtMultimedia 5.4
import QtQuick.Controls 1.2
import "../../../Js/qml.js" as Common


/**
多个摄像头测试
    /展示多个摄像头
    /遍历摄像头捕捉多个图片


BUG: 多个摄像头输出图会串图
    测试结果表明，多个摄像头和可能用的是同一个列表来存储截图
    每个摄像头的requestId是独立的，每次加1
    若requestId等于最后的requestId就会串图

解决方案2
    弄一个全局的最大requestId
    若请求到的requestId等于它，则多拍1次，直至大于这个id
    此外用定时器来延时拍照，否则相机会失败
*/
Column {
    width: 800
    height: 600
    spacing: 10



    // 摄像头视频展示区
    Row{
        id: videoContainer
        width: parent.width
        spacing: 10
        Repeater{
            model: QtMultimedia.availableCameras
            VideoOutput {
                width: 320
                height: 240
                source: Camera {
                    deviceId : modelData.deviceId
                    captureMode: 'CaptureStillImage'
                    imageCapture {
                        onImageCaptured: {
                            console.log('deviceId:' + deviceId + ', requestId:' + requestId);

                            // BUG: 多个摄像头情况下，requestId等于最后的requestId就会串图
                            // 若编号等于最大的编号，多拍1次，避免串图
                            if (requestId != maxRequestId)
                                imageContainer.children[index].source = preview;
                            else
                                timer.delayCapture(this);
                            maxRequestId = Math.max(requestId, maxRequestId);
                        }
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: parent.source.imageCapture.capture();
                }
            }
        }
    }

    // 延时拍照逻辑
    property int maxRequestId : 0;
    Timer{
        id: timer
        interval: 200  // 不能太小，会报错相机未准备好
        repeat: false
        property var camera;
        onTriggered: {
            if (camera != null)
                camera.imageCapture.capture();
        }
        function delayCapture(c){
            camera = c;
            start();
        }
    }

    // 遍历camera，一个一个截图
    Button{
        text: 'capture'
        width: 100
        onClicked: {
            for (var i=0; i<videoContainer.children.length; i++){
                var camera = videoContainer.children[i].source;
                if (camera != null)
                    camera.imageCapture.capture();
            }
        }
    }

    // 拍照后显示的图片
    Row{
        id: imageContainer
        width: parent.width
        spacing: 5
        Repeater{
            model: QtMultimedia.availableCameras
            Image {
                height: 100
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
