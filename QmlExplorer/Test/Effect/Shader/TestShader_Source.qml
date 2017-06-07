import QtQuick 2.0
import QtQuick.Controls 1.2


/**
ShaderEffect 的图像源
*/
Rectangle {
    width: 400; height: 400
    color: '#1e1e1e'

    Grid {
        anchors.centerIn: parent
        spacing: 20
        rows: 3; columns: 3

        // Image控件作为ShaderEffect的图像源
        Image {
            id: img
            width: 100; height: width
            source: '../images/tulips.jpg'
        }

        // ShaderEffectSource控件作为ShaderEffect的图像源
        ShaderEffectSource {
            id: ses
            sourceItem: Text{text:'Qt'; font.pixelSize: 70; color:'white'}
            smooth: true
            hideSource: false
            width: sourceItem.width;
            height: sourceItem.height
        }

        // 其它Item作为ShaderEffect的图像源, 加上语句layer.enabled: true
        Rectangle{
            id: rect
            width: 100; height: 100
            color: 'lightblue'
            TextField{
                width: 80; height: 80
                text: 'hello'
                anchors.centerIn: parent
            }
            layer.enabled: true   // 加上该语句可作为ShaderEffect的图像源
        }



        // ShaderEffect 输出
        WaveEffector{source: img}
        WaveEffector{source: ses}
        WaveEffector{source: rect}
    }
}
