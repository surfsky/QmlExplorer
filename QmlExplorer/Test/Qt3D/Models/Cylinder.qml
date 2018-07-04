import QtQuick 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0
import Qt3D.Input 2.0

Item3D {
    property alias name: cylinderMesh.objectName
    property alias radius: cylinderMesh.radius
    property alias length: cylinderMesh.length
    mesh: CylinderMesh {
        id: cylinderMesh
    }
}
