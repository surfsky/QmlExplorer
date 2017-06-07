import QtQuick 2.0


/**
测试用json作为数据源
*/
Flickable {
    id: root
    width: 600
    height: 600
    contentWidth: width
    contentHeight: 1000


    //----------------------------------------
    // json 原始数据（数组类型）
    //----------------------------------------
    property var json : [
        {jid:1, title:'title1'},
        {jid:2, title:'title2'},
        {jid:3, title:'title3'}
    ]


    //----------------------------------------
    // 行代理
    //----------------------------------------
    Component{
        id: d
        Rectangle{
            width: parent.width;
            height: 30
            Text {text: jid + '-' + title}
        }
    }


    //----------------------------------------
    // ListView
    //----------------------------------------
    Grid{
        width: root.width
        height: root.height
        spacing: 10
        columns: 2


        //----------------------------------
        // 绑定到“数字”，即循环次数
        //----------------------------------
        Text{text:'绑定到“数字”，即循环次数（成功）'}
        Flickable{
            width: 200;
            height: 100
            contentWidth: width
            contentHeight: 150
            clip:true
            Column {
                anchors.fill: parent
                Repeater {
                    model: 10
                    Text { text: "I'm item " + index }
                }
            }
        }


        //----------------------------------------------
        // json 字符串数组（可直接赋予model, 用modelData属性展示元素）
        //----------------------------------------------
        Text{text:'json 字符串数组（成功）'}
        ListView{
            width: 200
            height: 100
            delegate:  Rectangle{
                width: parent.width;
                height: 30
                Text {text: index + '-' + modelData}
            }
            model: ['apple', 'orange', 'banana']
        }

        Text{text:'json 字符串转化成ListModel（失败）'}
        ListView{
            width: 200
            height: 100
            delegate:  Rectangle{
                width: parent.width;
                height: 30
                Text {text: index + '-' + modelData}
            }
            model: ListModel{
                // listmodel.append 字符串数组有问题
                Component.onCompleted: {
                    append(['apple', 'orange', 'banana']);
                }
            }
        }

        //----------------------------------------------
        // json 对象数组（必须转化为ListModel才可使用）
        //----------------------------------------------
        Text{text:'json 对象数组（失败）'}
        ListView{
            width: 200
            height: 100
            model: [
                {jid:1, title:'title1'},
                {jid:2, title:'title2'},
                {jid:3, title:'title3'}
            ]
            delegate:  Rectangle{
                width: parent.width;
                height: 30
                Text {text: jid + '-' + title}
            }
            Component.onCompleted: {
                console.log(model);
            }
        }



        //----------------------------------------------
        // json 对象数组转化为ListModel
        //----------------------------------------------
        // 方法1：在Component.onCompleted事件中附加数据
        Text{text:'json对象数组转化为 listmodel（append方式）（成功）'}
        ListView{
            width: 200
            height: 100
            delegate: d
            model: model2
        }
        ListModel{
            id: model2
            Component.onCompleted: append(json);
        }


        // 方法2：全部用脚本创建并附加数据
        Text{text:'json对象数组转化为 listmodel（js方式）（成功）'}
        ListView{
            width: 200
            height: 100
            delegate: d
            model: getListModelFromJson(json, root)

            function getListModelFromJson(json, parent){
                var model = Qt.createQmlObject('import QtQuick 2.2; ListModel{}', parent);
                model.append(json);
                return model;
            }
        }
    }
}
