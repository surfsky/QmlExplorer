//![0]

var component;
var i;


function fly(i) {
//setTimeout(function(){createBlock(0,0)},1000);
    if(i == 1){

            component = Qt.createComponent("Effect/BubbleBlast.qml");
    }
    if(i == 2){

            component = Qt.createComponent("Effect/Cullet.qml");
    }

    if(i == 3){

            component = Qt.createComponent("Effect/Rotation.qml");
    }
    if(i == 4){

            component = Qt.createComponent("Effect/ParallelMove.qml");
    }
    if(i == 5){

            component = Qt.createComponent("Effect/VerticalMove.qml");
    }
    if(i == 6){

            component = Qt.createComponent("Effect/Quaky.qml");
    }
    if(i == 7){

            component = Qt.createComponent("Effect/Tornado.qml");
    }
    if(i == 8){

            component = Qt.createComponent("Effect/BubbleMove.qml");
    }
    if(i == 9){

            component = Qt.createComponent("Effect/Rain.qml");
    }
    if(i == 10){

            component = Qt.createComponent("Effect/Flipable.qml");
    }
    if(i == 11){

            component = Qt.createComponent("Effect/Star.qml");
    }
    if(i == 12){

            component = Qt.createComponent("Effect/Snow.qml");
    }
    if(i == 13){

            component = Qt.createComponent("Help.qml");
    }
    if(i == 14){

            component = Qt.createComponent("Effect/Rose.qml");
    }
    if(i == 15){

            component = Qt.createComponent("Effect/3D.qml");
    }
    // Note that if Block.qml was not a local file, component.status would be
    // Loading and we should wait for the component's statusChanged() signal to
    // know when the file is downloaded and ready before calling createObject().
    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(background);
        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(component.errorString());
            return false;
        }

    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        return false;
    }
    return true;
    component = null;
}


//![0]

