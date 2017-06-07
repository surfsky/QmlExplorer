import QtQuick 2.2

/**
图像及拉伸方式测试
*/
Grid{
    width: 640
    height: 480
    spacing: 10
    columns: 2

    Text{text: 'raw'; font.family: 'Arial'; font.pointSize: 11}
    Image {
        source: "qt58.png"
    }

    Text{text: 'stretch'}
    Image {
        width: 130; height: 100
        smooth: true
        source: "qt58.png"
    }

    Text{text: 'PreserveAspectFit'}
    Image {
         width: 130; height: 100
         fillMode: Image.PreserveAspectFit
         smooth: true
         source: "qt58.png"
     }

    // 在指定区域内，固定比例拉伸到最大
    Text{text: 'PreserveAspectCrop'}
    Image {
        width: 130; height: 100
        fillMode: Image.PreserveAspectCrop
        smooth: true
        source: "qt58.png"
        clip: true
    }

    Text{text: 'Tile'}
    Image {
        width: 120; height: 120
        fillMode: Image.Tile
        source: "qt58.png"
    }

    Text{text: 'TileVertically'}
    Image {
        width: 120; height: 120
        fillMode: Image.TileVertically
        smooth: true
        source: "qt58.png"
    }

    Text{text: 'TileHorizontally'}
    Image {
        width: 120; height: 120
        fillMode: Image.TileHorizontally
        smooth: true
        source: "qt58.png"
    }
}

