import QtQuick 2.0
import QtQuick.Controls 1.1

/**
测试自定义标题和行
- 切换可编辑模式
- 自定义标题和选择行
- 选择行背景色动画、高度动画

经过测试：自定义的行里面的文字都很模糊
可参考官方示例工程：tableview
*/
Column {
    width: 640
    height: 480
    spacing: 10

    // 代理选择下拉框
    ComboBox {
        id: delegateChooser
        width: 150
        x: 10; y: 10
        model: ListModel {
            id: delegatemenu
            ListElement { text: "紧凑" }
            ListElement { text: "选择行放大" }
            ListElement { text: "选择行可编辑" }
        }
    }

    // 表格视图
    TableView {
        model: largeModel
        anchors.margins: 10
        anchors.topMargin: 40
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        TableViewColumn {
            role: "name"
            title: "Name"
            width: 120
        }
        TableViewColumn {
            role: "age"
            title: "Age"
            width: 120
        }
        TableViewColumn {
            role: "gender"
            title: "Gender"
            width: 120
        }

        headerDelegate: BorderImage{
            source: "../../../images/header.png"
            border{left:2;right:2;top:2;bottom:2}
            Text {
                text: styleData.value
                anchors.centerIn:parent
                color:"#333"
            }
        }

        // 行代理（选择行变高、背景图片呼吸效果）
        rowDelegate: Rectangle {
            height: (delegateChooser.currentIndex == 1 && styleData.selected) ? 30 : 20
            Behavior on height{ NumberAnimation{} }

            color: styleData.selected ? "#448" : (styleData.alternate? "#eee" : "#fff")
            BorderImage{
                id: selected
                anchors.fill: parent
                source: "../../../images/selectedrow.png"
                visible: styleData.selected
                border{left:2; right:2; top:2; bottom:2}
                SequentialAnimation {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { target:selected; property: "opacity"; to: 1.0; duration: 900}
                    NumberAnimation { target:selected; property: "opacity"; to: 0.5; duration: 900}
                }
            }
        }

        itemDelegate: {
            if (delegateChooser.currentIndex == 2)
                return editableDelegate;
            else
                return delegate1;
        }
    }


    //--------------------------------------
    // 数据模型
    //--------------------------------------
    ListModel {
        id: largeModel
        Component.onCompleted: {
            for (var i=0 ; i< 500 ; ++i)
                largeModel.append({"name":"Person "+i , "age": Math.round(Math.random()*100), "gender": Math.random()>0.5 ? "Male" : "Female"})
        }
    }

    //--------------------------------------
    // 三个代理
    // 不太明白前两个代理的区别在哪儿
    //--------------------------------------
    Component {
        id: delegate1
        Item {
            //clip: true
            Text {
                width: parent.width
                anchors.margins: 4
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                elide: styleData.elideMode
                text: styleData.value !== undefined  ? styleData.value : ""
                color: styleData.textColor
            }
        }
    }

    Component {
        id: delegate2
        Text {
            width: parent.width
            anchors.margins: 4
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            elide: styleData.elideMode
            text: styleData.value !== undefined  ? styleData.value : ""
            color: styleData.textColor
        }
    }

    Component {
        id: editableDelegate
        Item {

            Text {
                width: parent.width
                anchors.margins: 4
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                elide: styleData.elideMode
                text: styleData.value !== undefined ? styleData.value : ""
                color: styleData.textColor
                visible: !styleData.selected
            }
            Loader { // Initialize text editor lazily to improve performance
                id: loaderEditor
                anchors.fill: parent
                anchors.margins: 4
                Connections {
                    target: loaderEditor.item
                    onAccepted: {
                        if (typeof styleData.value === 'number')
                            model.setProperty(styleData.row, styleData.role, Number(parseFloat(loaderEditor.item.text).toFixed(0)))
                        else
                            model.setProperty(styleData.row, styleData.role, loaderEditor.item.text)
                    }
                }
                // 选中行动态用编辑控件替代
                sourceComponent: styleData.selected ? editor : null
                Component {
                    id: editor
                    TextInput {
                        id: textinput
                        color: styleData.textColor
                        text: styleData.value
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: textinput.forceActiveFocus()
                        }
                    }
                }
            }
        }
    }

}
