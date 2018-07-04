import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Scene3D 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0
import Qt3D.Input 2.0
import Qt3D.Logic 2.0
import "./Models"


/*
测试 Scene3D
- 三维和二维组件混杂显示
*/
Scene3D {
    id: scene3D
    width: 800;
    height: 600;
    focus: true
    aspects: ["render", "logic", "input"]

    // 三维场景
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
            position: Qt.vector3d( 0.0, 0.0, 7.5 )
            upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
            viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
        }
        OrbitCameraController{
            id: cameraController;
            camera: mainCamera
        }

        // 三维实体
        Cube{
            transform.rotationX : 30;
            transform.rotationY : 45;
        }
    }

    // 二维场景
    children: Item{
        anchors.fill: parent;
        Rectangle{
            width: parent.width;
            height: 50;
            color: 'black'
            opacity: 0.8;
            Text{ text: "Scene3D demo" ; color:'white'; anchors.centerIn: parent;}
        }
    }
}
