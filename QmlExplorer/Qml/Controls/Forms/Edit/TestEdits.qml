import QtQuick 2.0
import QtQuick.Controls 1.2

Column {
    width: 600
    height: 400
    spacing: 10


    CapsuleEdit{}
    Row{
        spacing: 5
        IPEdit{id:edtIP; text: '192.168.1.1'; enabled: true}
        Button{text: 'Set IP'; onClicked: edtIP.text = '134.104.69.201';}
        Button{text: 'Get IP'; onClicked: lblIP.text = edtIP.text;}
        Text{id: lblIP}
    }
}

