import QtQuick 2.0
import QtMultimedia 5.4
import QtQuick.Controls 1.2
import "../../../Js/qml.js" as Common


/**
多个摄像头测试
    /展示多个摄像头
    遍历摄像头捕捉多个图片


BUG: 多个摄像头输出图会串图
    测试结果表明，多个摄像头和可能用的是同一个列表来存储截图
    每个摄像头的requestId是独立的，每次加1
    如果requestId一样的话，输出的图片就是一样的
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
                            imageContainer.children[index].source = preview;  // 有问题，多个摄像头就会串图
                        }
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        var requestId = parent.source.imageCapture.capture();
                        //console.log('deviceId:' + parent.source.deviceId + ', requestId:' + requestId);
                    }
                }
            }
        }
    }

    // 捕捉按钮
    Button{
        text: 'capture'
        width: 100
        onClicked: {
            console.log(Common.getChildrenString(videoContainer, 0));
            console.log(Common.getChildrenString(imageContainer, 0));
            // 遍历repeater中的camera，一个一个的截图
            for (var i=0; i<videoContainer.children.length; i++){
                var camera = videoContainer.children[i].source;
                if (camera != null){
                    console.log(camera.deviceId);
                    //var location = 'capture' + index + '.png';
                    //camera.imageCapture.captureToLocation(location);
                    camera.imageCapture.capture();
                }
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
