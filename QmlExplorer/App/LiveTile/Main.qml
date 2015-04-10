import QtQuick 2.0
import QtQuick.Controls 1.2

/**
模仿windowsphone live tile效果
*/
Rectangle {
    id: root
    width: 500
    height: 800
    color: 'black'

    // 右侧的箭头
    Rectangle{
        x: root.width - 80
        y: grid.y
        width: 50
        height: 50
        radius: width/2
        color: 'transparent'
        border.color: 'white'
        border.width: 2
        antialiasing: true
        Text{
            anchors.centerIn: parent
            text: '>'
            color: 'white'
            font.bold: true
            font.pixelSize: 30
        }
    }

    // 当前激活磁贴
    property Tile activeTile;


    // 子页面用loader动态加载
    Loader{
        id: loader
        z: 98
        visible: false
        anchors.fill: parent
        BusyIndicator{
            id: busy
            running: false;
            anchors.centerIn: parent
        }
        onSourceChanged: busy.running = true;
        onLoaded: busy.running = false;
        // 捕获错误信息
        onStatusChanged: {
            if (status == Loader.Error){
                busy.running = false;
                loader.source = "Error.qml"
            }
        }
        // 捕获页面退出消息
        Connections {
            target: loader.item
            onExit: {
                loader.source = '';
                activeTile.state = '';
            }
        }
    }


    // 磁贴阵列
    GridView{
        id: grid
        x:20; y:50
        width: root.width - 50
        height: root.height-y
        cellWidth: 200; cellHeight: 200
        clip: true
        delegate: Tile{
            width: grid.cellWidth-20;
            height: grid.cellHeight-20
            rootItem: root
            text: title
            tag: url
            onTileActive: {
                loader.visible = true;
                loader.source = tag;
                activeTile = this;
            }
        }
        model: ListModel{
            Component.onCompleted: {
                append([
                    {title:'Image',     url:'Page1.qml'},
                    {title:'Colr',      url:'Page2.qml'},
                    {title:'Rectangle', url:'Page3.qml'},
                    {title:'Item',      url:'Page4.qml'},
                    {title:'Font',      url:'Page1.qml'},
                    {title:'Gradient',  url:'Page2.qml'},
                    {title:'ImagePng',  url:'Page3.qml'},
                    {title:'Timer',     url:'Page4.qml'}
                 ]);
            }
        }
    }


}
