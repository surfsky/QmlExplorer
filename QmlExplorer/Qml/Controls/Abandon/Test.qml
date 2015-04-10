import QtQuick 2.2
import "../../app/Clock/"
import "./ImageView"


Column{
    width: 640
    height: 480
    Row {
        Circle{
            radius : 50
            color: 'lightgreen'
            x:0
        }
        Circle{
            radius : 50
            color: 'lightblue'
            opacity: 0.6
            x:40
        }
    }

    ImageWithLoading{
        source: "http://qt.digia.com/Static/Images/QtLogo.png"
    }

    Item {
        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: txtTime.text = new Date().toLocaleString(Qt.locale("zh_CN"), 'yyyy-MM-dd HH:mm:ss')
        }
        Text { id: txtTime; antialiasing:true; font.pixelSize: 20}
    }

    Clock{}
}
