import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Shapes 2.0

/**
代码已经跑不起来了，供参考
测试3D立方体
更多Quick3D请查看qt3d/examples目录
*/
Viewport {
    id: view
    width: parent.width
    height: parent.height
    anchors.centerIn: parent

    Cube {
        scale: 2
        effect: Effect {
            blending: true
            color: "#8880C342"
            texture: "qtlogo.png"
            decal: true
        }

        transform: [
            Rotation3D { id: rotateX; axis: Qt.vector3d(1, 0, 0) },
            Rotation3D { id: rotateY; axis: Qt.vector3d(0, 1, 0) },
            Rotation3D { id: rotateZ; axis: Qt.vector3d(0, 0, 1) }
        ]


        RotationAnimation { target: rotateX; running: true; loops: Animation.Infinite; property: "angle"; from: 0; to : 360.0; duration: 3000; }
        RotationAnimation { target: rotateY; running: true; loops: Animation.Infinite; property: "angle"; from: 0; to : 360.0; duration: 4000; }
        RotationAnimation { target: rotateZ; running: true; loops: Animation.Infinite; property: "angle"; from: 0; to : 360.0; duration: 5000; }
    }
}

