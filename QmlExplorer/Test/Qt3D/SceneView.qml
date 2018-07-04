import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Scene3D 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0
import Qt3D.Input 2.0
import "../../Qml/Controls"


/*
3D 运行视图，可直接在 qmlscence 下运行
包含：
    前向渲染器
    轨道相机
    当前opengl版本
    帧率
    相机位置，相机目标
    选中物件
使用：
    SceneView{ Entity {....} }

todo: 合并SceneEntity, 或删除掉SceneEntity
    可以继承至SceneEntity，二位部分写在children:[] 里面即可
*/
Item{
    id: root;
    width: 1000;
    height: 800;

    // 附属控件
    property bool showFPS : true;
    property bool showGLVersion : true;
    property bool showCameraInfo : true;
    property bool showSelectedEntiy: true;
    property color labelColor: 'black';
    property Entity selectedEntity : null;

    // 3d 场景属性
    default property alias items : mainEntity.childNodes;
    property alias camera : mainCamera;
    property alias renderSettings: renderSettings;
    property alias clearColor: render.clearColor;
    property alias cameraController: cameraController;


    //--------------------------------------------------
    // 附属控件
    //--------------------------------------------------
    FPS{
        x: 10; y: 10; z:100;
        visible: root.showFPS;
        color: root.labelColor;
    }

    // opengl info
    Text {
        y: 10; z:100;
        anchors.right: parent.right;
        anchors.rightMargin: 10;
        text: "Open%4 %1.%2 %3"
            .arg(OpenGLInfo.majorVersion)
            .arg(OpenGLInfo.minorVersion)
            .arg({0: "NoProfile", 1: "CoreProfile", 2: "CompatibilityProfile"}[OpenGLInfo.profile])
            .arg({0: "Unspecified", 1: "GL", 2: "GLES"}[OpenGLInfo.renderableType])
        visible: root.showGLVersion;
        color: root.labelColor;
    }

    // camera info
    Text{
        x : 10; z:100;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 10;
        text: "(%1, %2, %3) -> (%4, %5, %6)"
            .arg(camera.position.x).arg(camera.position.y).arg(camera.position.z)
            .arg(camera.viewCenter.x).arg(camera.viewCenter.y).arg(camera.viewCenter.z)
        visible: root.showCameraInfo
        color: root.labelColor;
    }

    // selected entity
    Text{
        x : 10; z:100;
        anchors.right:  parent.right;
        anchors.rightMargin: 10;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 10;
        text: selectedEntity == null ? "" : selectedEntity.toString();
        visible: root.showSelectedEntiy
        color: root.labelColor;
    }



    //--------------------------------------------------
    // 三维场景
    //--------------------------------------------------
    Scene3D {
        id: scene3D
        anchors.fill: parent;
        focus: true
        aspects: ["render", "logic", "input"]

        // entity running environment
        Entity{
            id: mainEntity
            components: [
                RenderSettings {
                    id: renderSettings;
                    activeFrameGraph: ForwardRenderer {
                        id: render;
                        camera: mainCamera
                        clearColor: "white"
                    }
                    pickingSettings.pickMethod: PickingSettings.TrianglePicking
                },
                InputSettings { }
            ]
            Camera {
                id: mainCamera
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 40
                aspectRatio: 4/3
                nearPlane : 0.1
                farPlane : 10000.0
                upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                position: Qt.vector3d( 0.0, 0.0, 7.5 )
                viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
            }
            OrbitCameraController{
                id: cameraController;
                camera: mainCamera
            }

            //--------------------------------------------
            // 遍历所有子Entity，注入selected事件
            //--------------------------------------------
            Component.onCompleted: {
                setEntity(mainEntity);
            }

            // 遍历子控件，附加上selected事件
            function setEntity(entity)
            {
                // entity
                if (!isEntity(entity)) return;
                if (entity.hasOwnProperty('onSelected'))
                    entity.onSelected.connect(function(entity){root.selectedEntity = entity; });

                // children
                var children = entity.childNodes;  // 会把子成员属性等也打印出来，改改。只需要打印components 和 Entity 成员
                for (var i = 0; i < children.length; i++)
                {
                    var child = children[i];
                    if (isEntity(child)){
                        setEntity(child);
                    }
                }
            }

            // 判断对象是不是 Entity
            function isEntity(entity){
                return entity != null && entity.hasOwnProperty('components') && entity.hasOwnProperty('propertyTrackingOverrides');
            }
        }
    }
}

