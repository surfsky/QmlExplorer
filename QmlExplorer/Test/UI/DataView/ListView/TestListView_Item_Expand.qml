import QtQuick 2.0
import QtQuick.Controls 1.2

/**
点击item可下拉展开的列表
*/
Rectangle {
    width: 600
    height: 600

    ListView{
        id: lv
        anchors.fill: parent
        model: model
        delegate: delegate
        currentIndex: -1
        header: Rectangle{
            width: parent.width
            height: 30
            color: '#f0f0f0'
            Text{
                anchors.centerIn: parent
                text: '请点击行'
            }
        }
    }

    ListModel{
        id: model
        ListElement {name: "Apple"; cost: 2.45; detail:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
        ListElement {name: "Orange"; cost: 3.25; detail:'0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'}
        ListElement {name: "Banana"; cost: 1.95; detail:'bcccccccccccccccccccccccccccccccccccccccccc'}
        ListElement {name: "Apple"; cost: 2.45; detail:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
        ListElement {name: "Orange"; cost: 3.25; detail:'obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'}
        ListElement {name: "Banana"; cost: 1.95; detail:'bcccccccccccccccccccccccccccccccccccccccccc'}
        ListElement {name: "Apple"; cost: 2.45; detail:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
        ListElement {name: "Orange"; cost: 3.25; detail:'obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'}
        ListElement {name: "Banana"; cost: 1.95; detail:'bcccccccccccccccccccccccccccccccccccccccccc'}
        ListElement {name: "Apple"; cost: 2.45; detail:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
        ListElement {name: "Orange"; cost: 3.25; detail:'obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'}
        ListElement {name: "Banana"; cost: 1.95; detail:'bcccccccccccccccccccccccccccccccccccccccccc'}
    }

    Component {
        id: delegate
        Item{
            id: itemView
            width: lv.width
            height: minHeight
            clip: true
            property int minHeight: 30;

            // 点击设置为选择行
            MouseArea {
                anchors.fill:parent;
                onClicked: lv.currentIndex = (lv.currentIndex!=index) ? index : -1;
            }

            // 展示内容
            Column{
                anchors.fill: parent
                spacing: 10
                height: 80

                Rectangle{width: parent.width; height:1; color: '#d0d0d0'}
                Rectangle{
                    width:parent.width; height: 12
                    Text {id: lblName; text:name + " " + cost;height:12; x:10}
                }
                Rectangle{
                    id: panelDetail
                    color: 'lightgreen'
                    width: parent.width
                    height: parent.height-1-12
                    Text {text: detail; color: 'gray'; x:10; anchors.verticalCenter: parent.verticalCenter}
                    //Button {text: 'Close'; onClicked: itemView.state=''; anchors.right: parent.right; anchors.rightMargin:10; anchors.verticalCenter: parent.verticalCenter}
                }
            }

            // 状态和动画
            state : index==lv.currentIndex ? 'details' : ''
            states: [
                State {
                    name: ""
                    PropertyChanges { target: itemView;  height:itemView.minHeight;}
                    PropertyChanges { target: panelDetail;  visible: false }
                },
                State {
                    name: "details" ;
                    PropertyChanges {target: itemView ;  height:80; }
                    PropertyChanges {target: panelDetail;   visible: true}
                }
            ]
            Behavior on height {
                PropertyAnimation { duration: 200; easing.type: Easing.Linear}
            }
        }
    }
}
