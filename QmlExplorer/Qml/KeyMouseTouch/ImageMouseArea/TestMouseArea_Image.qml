import QtQuick 2.0
import "../../cool/Effector/"


/**
不规则形状（用png定义）点击检测
加上dropshadow效果，鼠标点击发光
*/
Rectangle {
    width: 600
    height: 600

    Text {
        id: lblInfo
        x: 10;
        y: 10;
        text: 'Plz click the image'
    }

    Image{
        id: img
        source: 'pentagon.png'
        anchors.centerIn: parent;
        ImageMouseArea{
            imageUrl: 'pentagon.png'
            anchors.fill: parent
            onPressed: {
                lblInfo.text = '';
                if (!isCurrentPointTransparent())
                    effector.start();
            }

        }
    }
    ShineEffector{
        id: effector
        shineSource: img
        shineRadius: 36
        shineColor: 'yellow'
    }
}
