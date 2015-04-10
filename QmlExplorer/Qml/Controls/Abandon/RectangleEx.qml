import QtQuick 2.0


/**带阴影的矩形*/
Rectangle{
    id: rect
    width: 100
    height: 100
    z:1
    radius: 10
    color: 'lightblue'
    //border.width: 1
    //border.color: 'gray'


    function setShadow(){
        shadow.parent = rect.parent;
        shadow.z = rect.z - 1;
        shadow.anchors.left = rect.left;
        shadow.anchors.top = rect.top;
        //shadow.x = rect.x;
        //shadow.y = rect.y;
        //console.log('parent=' + parent);
    }

    Shadow{
        id: shadow
        z:0
        targetWidth: rect.width
        targetHeight: rect.height
        targetRadius: rect.radius
        visible: rect.visible
    }

    Component.onCompleted: setShadow();
}
