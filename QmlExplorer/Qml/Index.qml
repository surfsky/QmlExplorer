import QtQuick 2.0


/**
主入口
*/
QtObject {
    property var splash: Splash{onTimeout: mainWindow.visible=true;}
    property var mainWindow: Main{}


    // FAIL
    //Splash{onTimeout: mainWindow.visible=true;}
    //QmlExplorer{id: mainWindow}
}
