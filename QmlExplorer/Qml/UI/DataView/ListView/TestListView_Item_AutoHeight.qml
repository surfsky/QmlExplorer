import QtQuick 2.0

/**
ListView 行高根据子元素自动适配
*/
Rectangle {
    width: 200; height: 300

    ListView {
        id: listView
        width: 200;
        height: parent.height
        x: 30
        model: pets
        delegate: petDelegate
    }

    ListModel {
        id: pets
        ListElement {name: "Pollyjfksjflksjlfjsjmall"; clr: 'yellow'}
        ListElement {name: "Pennyfjslfjlsjfljsjflsjfljslfjlsjlfle"; clr: 'blue'}
        ListElement {name: "Warren"; clr: 'red'}
        ListElement {name: "Spot"; clr: 'pink'}
    }

    Component {
        id: petDelegate
        Rectangle {
            color: clr
            width: 50
            //height: txt.contentHeight+10
            height: txt.implicitHeight+10
            Text{
                id: txt
                text: name
                width: 50
                anchors.centerIn: parent
                wrapMode: Text.WrapAnywhere
            }
        }
    }
}
