import QtQuick 2.1


/*!
Nested ListView demo
    /嵌套的ListModel数据
    /json数据
    /子视图
    /返回
    /视图切换动画
    /美化
    /返回父级用反方向动画
    当前选择行
    异步加载子目录
    model可任意定制
    当前行的delegate可定制
接口
    getModel(item)
    hasChild(item)
    folderDelegate
    fileDelegate
    itemClicked
*/
Rectangle {
    id:root
    width: 400
    height: 500

    // 数据
    ListModel{
        id: model
        Component.onCompleted: {
            append([
                {title:"Item 1", items:[
                    {title:"Item 11", items:[
                          {title:"Item 111"},
                          {title:"Item 112"},
                          {title:"Item 113"},
                          {title:"Item 114"}
                    ]},
                    {title:"Item 12", items:[
                        {title:"Item 121"},
                        {title:"Item 122"}
                   ]}
                ]},
                {title:"Item 2", items:[
                    {title:"Item 21", items:[
                          {title:"Item 211"},
                          {title:"Item 212"},
                          {title:"Item 213"}
                    ]}
                ]}
            ]);
        }
    }

    // 行UI代理
    Component {
        id: delegate
        Rectangle {
            height: 40
            width: view.width
            Text {
                color: "black"
                font.bold: true
                text: title
                anchors.verticalCenter: parent.verticalCenter
                x: 10
            }
            Text {
                text: ">"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                visible: model.items != undefined
            }
            Rectangle{
                height: 1
                width: parent.width
                color: "#e0e0e0"
                y: parent.height - 1
            }

            // 点击行切换model
            MouseArea {
                anchors.fill: parent
                onPressed: parent.color = '#f0f0f0';
                onReleased: parent.color = 'white';
                onClicked: {
                    if (model.items != undefined)
                    {
                        if (model.items.get(0).title != "...")
                            model.items.insert(0, {title: "...", "parent": view.model})
                        _direction = 'forward';
                        view.model = model.items
                    }
                    else if (title == "...")
                    {
                        _direction = 'back';
                        view.model = model.parent;
                    }
                }
            }
        }
    }

    // 内部属性
    property string _direction : 'forward';   // 前向、后向

    // listview
    ListView{
        id: view
        //anchors.fill:  parent  // 用了这玩意动画就无效了
        width: parent.width;
        height: parent.height;
        x: 0; y:0;
        model: model
        delegate: delegate

        // 场景切换动画
        onModelChanged: {
            if (_direction == 'forward')  aniForward.start();
            else                          aniBack.start();
        }
        PropertyAnimation on x{id: aniForward; from: parent.width; to: 0}
        PropertyAnimation on x{id: aniBack; from: -parent.width; to: 0}
    }

}
