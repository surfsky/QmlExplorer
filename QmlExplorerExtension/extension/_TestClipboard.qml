import QtQuick 2.0
import QtQuick.Controls 1.2


/**
将item转化为图像(Qt 5.4)
*/
Column{
    width: 600
    height: 400
    spacing: 10


    // 源组件
    Rectangle {
        id: source
        width: 100
        height: 100
        gradient: Gradient {
            GradientStop { position: 0; color: "steelblue" }
            GradientStop { position: 1; color: "black" }
        }
    }

    // 点击将源组件转化为图像
    Button{
        text: '获取图像'
        onClicked:{
            source.grabToImage(function(result) {
               //result.save("something.png");
               img.source = result.url;
           });
        }
    }

    // 目标图像
    Image{
        id: img
    }
}

