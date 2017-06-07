import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import "../../Controls/"


ColumnLayout {
    width: 640
    height: 640
    spacing: 10


    Text{ text: 'row layout'}
    RowLayout{
        spacing: 10
        Square {text:'1'}
        Square {text:'2'}
        Square {text:'3'}
        Square {text:'4'}
        Square {text:'5'; Layout.fillWidth: true;}
    }

    Text{ text: 'column layout'}
    ColumnLayout{
        spacing: 10
        Square {text:'1'}
        Square {text:'2'}
        Square {text:'3'}
    }

    Text{ text: 'grid layout'}
    GridLayout{
        columns: 3
        //spacing: 10
        columnSpacing: 10
        Circle {text:'1'}
        Circle {text:'2'}
        Circle {text:'3'}
        Circle {text:'4'}
        Circle {text:'5'}
        Circle {text:'6'}
        Circle {text:'7'}
        Circle {text:'8'}
        Circle {text:'9'; Layout.fillWidth: true;}
    }

    Text{ text: 'flow'}
    Flow{
        spacing: 10
        Layout.fillWidth: true
        Square {text:'1'}
        Square {text:'2'}
        Square {text:'3'}
        Square {text:'4'}
        Square {text:'5'}
        Square {text:'6'}
        Square {text:'7'}
        Square {text:'8'}
        Square {text:'9'}
    }

    Text{ text: 'auto resize text area'}
    TextArea {
        id: t3
        text: "This fills the whole cell"
        Layout.minimumHeight: 30
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

}
