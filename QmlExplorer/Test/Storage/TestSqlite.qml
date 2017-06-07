import QtQuick 2.0
import QtQuick.Controls 1.2
import "db.js" as Db
import "../../js/string.js" as String

/**
测试数据库
*/
Rectangle {
    id: root
    width: 600
    height: 600

    property int toolbarHeight: 40
    property int listHeight: 40


    // toolbar
    Rectangle{
        width: parent.width;
        height: root.toolbarHeight;
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightgray" }
            GradientStop { position: 1.0; color: "lightblue" }
        }

        Row{
            spacing: 5
            anchors.verticalCenter: parent.verticalCenter

            // list
            Button{
                text: 'list'
                onClicked: showData();
            }

            // add
            Button{
                text: 'insert'
                onClicked: {
                    Db.addProject('nameX', 'codeX');
                    showData();
                }
            }
        }

    }

    // show
    function showData(){
        data.clear();
        var array = Db.getProjects();
        for (var i=0; i<array.length; i++)
        {
            var item = {
                pid: array[i].id,
                name:array[i].name,
                code:array[i].code
                };
            data.append(item);
        }
        list.model = data;
        list.update();
    }

    // model
    ListModel{
        id: data
        ListElement {pid: 0; name:'name0'; code:'code0'}
        ListElement {pid: 1; name:'name1'; code:'code1'}
        ListElement {pid: 2; name:'name2'; code:'code2'}
    }

    // list
    ListView{
        id: list
        x:0;
        y:root.toolbarHeight;
        height: parent.height - root.toolbarHeight
        width: parent.width


        model: data
        delegate: Column{
            anchors.leftMargin: 5;
            width: parent.width
            height: root.listHeight
            Text {text: '<b>' + pid + '-' + name + '</b>'; font.pointSize: 14}
            Text {text: code}
            Rectangle {
                width: parent.width;
                height:1;
                color: 'lightgray';
            }
        }
    }

    // init
    Component.onCompleted: {
        Db.init();
    }

}
