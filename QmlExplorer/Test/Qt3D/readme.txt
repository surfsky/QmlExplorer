Qt3D 简单测试，详细 Qt3D 测试请参考另外一个项目 QmlStudio
Qt 3D 一直处于进化中，代码变更很大，老代码不能跑了

-------------------------------------------
-- 一些代码变化
-------------------------------------------
import
    import Qt3D 2.0            -->    Qt3D.Core 2.0
    import Qt3D.Shapes 2.0     -->    null

Item3D
    Item3D {
        mesh: Mesh {source: ....}
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
    }
    -> 演化为组件系统
    Entity{components: [mesh, transform, material]}
    官方的解释是这样更灵活，可以无限扩展components能力
    但实际使用时还是必须封装的，例如：
    Entity3D{
        mesh:
        material:
        transform:
        layer:
        ....
    }


Viewport
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
    }
    ->
    Scene3D
    SceneGrapha.....
    Entity{
    }


