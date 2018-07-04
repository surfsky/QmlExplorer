import QtQuick 2.3
import Qt3D 2.0
import Qt3D.Shapes 2.0

/*
代码已经跑不起来了
但非常简洁，供参考
*/
Viewport {
    width: 640; height: 480
    camera: Camera {
        eye: Qt.vector3d(0, 4, 12);
    }
    // 灯光
    light: Light {
        ambientColor: "black"; // 环境光
        constantAttenuation: 1;
        diffuseColor: "white"; // 慢发射
        specularColor: "white"; //镜面光
    }
    // 设置场景的环境光
    lightModel: LightModel {
        ambientSceneColor: Qt.rgba(0.2, 0.2, 0.2, 1.0);
    }


    // 囊状
    Capsule {
        radius: 0.5
        length: 3.0
        scale: 0.5
        position: Qt.vector3d(-2, 1, 0);
        effect: Effect {
            color: "#aaca00"
        }
    }
    // 立方体
    Cube {
        scale: 0.5
        position: Qt.vector3d(-1, 1, 0);
        effect: Effect {
            color: "#aaca00"
            texture: "qtlogo.png"
        }
    }
    // 圆柱体
    Cylinder {
         radius: 0.5
         length: 3.0
         scale: 0.5
         position: Qt.vector3d(0, 1, 0);
         effect: Effect {
             color: "#aaca00"
         }
     }
    // 线
    Line {
        vertices: [
           0, 0, 0,
           0, 0, 1,
           0, 1, 1
        ]
        position: Qt.vector3d(-2.0, 0, 0);
        effect: Effect {
            color: "#aaca00"
        }
    }
    // 点
    Point {
        vertices: [
           0, 0, 0,
           1, 1, 1,
           -1, -1, -1
                ]
        pointSize: 0.5;
        position: Qt.vector3d(1, -1, 0);
        effect: Effect {
            color: "white"
        }
    }
    // 四边形
    Quad {
        scale: 0.5
        position: Qt.vector3d(0, 0, 0);
        effect: Effect {
            color: "#aaca00"
            texture: "qtlogo.png"
        }
    }
    // 球体
    Sphere {
        radius: 0.5
        position: Qt.vector3d(-2, -1, 0);
        effect: Effect {
            color: "#aaca00"
        }
    }
    // 茶壶
    Teapot {
        scale: 0.5
        position: Qt.vector3d(-1, -1, 0);
        effect: Effect {
            color: "#aaca00"
            //texture: "qtlogo.png"
            decal: true
        }
    }
}
