import QtQuick 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0
import Qt3D.Input 2.0


// Item3D
Entity {
    property GeometryRenderer mesh;
    property Material material : PhongMaterial{}
    property alias transform : transform;
    property alias scale : transform.scale;


    Transform{id: transform}
    components: [mesh, transform, material]
}
