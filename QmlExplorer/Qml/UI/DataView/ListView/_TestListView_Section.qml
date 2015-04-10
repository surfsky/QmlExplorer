import QtQuick 2.0

/**
带分组的listview
    /分组（根据属性size）
    /自定义section head
    模拟ios通讯录
        右侧加上字母栏
        点击字母，列表跳转到对应section
*/
ListView {
    id: view
    width: 500
    height: 500

    // section
    section.labelPositioning: ViewSection.CurrentLabelAtStart  // && ViewSection.InlineLabels && NextLabelAtEnd
    section.property: "size"
    section.criteria: ViewSection.FullString
    section.delegate: Rectangle {
        width: 500
        height: childrenRect.height
        color: "lightsteelblue"
        Text {
            text: section
            font.bold: true
            font.pixelSize: 20
        }
    }

    // model & delegate
    delegate: Row{
        spacing: 5
        Text { text: size; font.pixelSize: 18 ; width: 70}
        Text { text: name; font.pixelSize: 18 }
    }
    model: ListModel {
        id: animalsModel
        ListElement { name: "Ant"; size: "Tiny" }
        ListElement { name: "Flea"; size: "Tiny" }
        ListElement { name: "Parrot"; size: "Small" }
        ListElement { name: "Guinea pig"; size: "Small" }
        ListElement { name: "Rat"; size: "Small" }
        ListElement { name: "Butterfly"; size: "Small" }
        ListElement { name: "Dog"; size: "Medium" }
        ListElement { name: "Cat"; size: "Medium" }
        ListElement { name: "Pony"; size: "Medium" }
        ListElement { name: "Koala"; size: "Medium" }
        ListElement { name: "Horse"; size: "Large" }
        ListElement { name: "Tiger"; size: "Large" }
        ListElement { name: "Giraffe"; size: "Large" }
        ListElement { name: "Elephant"; size: "Huge" }
        ListElement { name: "Whale"; size: "Huge" }
    }


    // 无法直接设置当前section，只能考虑自己处理 model，并用positionViewAtIndex()定位
    //Component.onCompleted: ListView.section='Medium'
    //Component.onCompleted: view.currentSection='Medium'
}
