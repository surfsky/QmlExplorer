import QtQuick 2.0

/*!
列表项目向左拖动显示删除菜单
修改逻辑
   点击行切换菜单
   拉伸左侧部分，菜单在下层即可
   用currentIndex来设置状态：选中的显示隐藏菜单
   只显示一行菜单项
*/
Rectangle {
    width: 300
    height: 600

    ListModel{
        id: model
        ListElement {name: "Apple"; cost: 2.45; detail:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
        ListElement {name: "Orange"; cost: 3.25; detail:'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'}
        ListElement {name: "Banana"; cost: 1.95; detail:'ccccccccccccccccccccccccccccccccccccccccccc'}
        ListElement {name: "Apple"; cost: 2.45; detail:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
        ListElement {name: "Orange"; cost: 3.25; detail:'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'}
        ListElement {name: "Banana"; cost: 1.95; detail:'ccccccccccccccccccccccccccccccccccccccccccc'}
        ListElement {name: "Apple"; cost: 2.45; detail:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
        ListElement {name: "Orange"; cost: 3.25; detail:'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'}
        ListElement {name: "Banana"; cost: 1.95; detail:'ccccccccccccccccccccccccccccccccccccccccccc'}
        ListElement {name: "Apple"; cost: 2.45; detail:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}
        ListElement {name: "Orange"; cost: 3.25; detail:'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb'}
        ListElement {name: "Banana"; cost: 1.95; detail:'ccccccccccccccccccccccccccccccccccccccccccc'}
    }

    Component {
        id: delegate
        Column{
            width: lv.width
            height: 30
            clip: true
            MouseArea{
                anchors.fill: parent
                onClicked: lv.currentIndex = index;
            }

            ListView{
                width: lv.width
                height: 29
                orientation: ListView.Horizontal        // 横向放置
                snapMode: ListView.SnapOneItem          // 只显示一个元素
                boundsBehavior: Flickable.StopAtBounds  // 到最边了就不允许拖拽

                //contentX: currentIndex==index ? width : 0
                //Component.onCompleted: positionViewAtIndex(1, GridView.Beginning)

                model: VisualItemModel{
                    Rectangle {
                        id: content
                        width: lv.width
                        height:29
                        color:'white'
                        Text {
                            id: lblName
                            text:name + " " + cost
                            anchors.verticalCenter: parent.verticalCenter
                            x: 10
                        }
                    }
                    Row{
                        width:120
                        height:29
                        // 删除按钮
                        Rectangle{
                            id: btn
                            width: 60
                            height: 29
                            color: 'red'
                            Text{text: 'Delete'; anchors.centerIn: parent; color:'white'}
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.log('del ' + name);
                                    model.remove(lv.currentIndex)
                                }
                            }
                        }
                        // 删除按钮
                        Rectangle{
                            id: btn2
                            width: 60
                            height: 29
                            color: 'green'
                            Text{text: 'Update'; anchors.centerIn: parent; color:'white'}
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.log('mod ' + name);
                                }
                            }
                        }
                    }

                }
            }
            Rectangle{
                width: lv.width
                height: 1
                color: '#d0d0d0'
            }
        }
   }

    ListView{
        id: lv
        anchors.fill: parent
        model: model
        delegate: delegate
        header: Rectangle{
            width: parent.width
            height: 30
            color: '#f0f0f0'
            Text{
                anchors.centerIn: parent
                text: '请左滑行项目'
            }
        }
    }

}
