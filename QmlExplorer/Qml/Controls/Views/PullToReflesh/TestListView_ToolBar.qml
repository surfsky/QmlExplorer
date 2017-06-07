import QtQuick 2.0
import QtQuick.Controls 1.2


/**
测试工具栏和listview协同
- 工具栏独立于listview
- listview下拉到顶，显示工具栏，listview调整位置
- 工具栏定时缩回
*/
Rectangle {
    width: 300
    height: 400

    Timer{
        id: timer; running: false; interval: 7000; repeat: false
        onTriggered: {
            searchField.visible = false;
        }
    }

    //-------------------------------------------
    // 搜索工具栏
    //-------------------------------------------
    Rectangle{
        id: searchField
        width: parent.width
        height: 30
        color: '#f0f0f0'
        visible: false

        Rectangle{
            width: parent.width-20
            height: 22
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            radius: height/2

            TextInput{
                width: parent.width-20
                anchors.centerIn: parent
                onTextChanged: {
                    timer.restart();
                    if(text.length > 0 )  listModel.applyFilter(text);
                    else                  listModel.reload();
                }
                onVisibleChanged: {
                    if( visible) focus = true
                }
                Behavior on visible {
                    NumberAnimation{ duration: 200 }
                }
            }
        }
    }


    //-------------------------------------------
    // 列表
    //-------------------------------------------
    ListView {
        id:listView
        clip: true
        width: parent.width
        height: parent.height
        model: listModel
        delegate: Text{text: name}

        y: searchField.visible ? searchField.height : 0
        Behavior on y {
            NumberAnimation{ duration: 200 }
        }

        // 如果下拉到一定程序，就显示搜索工具栏
        onContentYChanged: {
            if( contentY < -50 ) {
                searchField.visible = true;
                timer.running = true;
            }
        }
    }


    //-------------------------------------------
    // 模型
    //-------------------------------------------
    ListModel {
        id: listModel
        Component.onCompleted: {
            reload();
        }
        function reload() {
            clear();
            var books = getAllBooks();
            append(books);
        }
        function applyFilter(bookName) {
            var books = getAllBooks();
            clear();
            for( var i=0; i < books.length ; ++i ) {
                var book = books[i];
                if (book.name.indexOf(bookName) != -1)
                    append(book);
            }
        }
        function getAllBooks(){
            var c = 'A'.charCodeAt();
            var list = new Array();
            for( var i=0; i < 50 ; ++i ) {
                list[i] = {name: String.fromCharCode(c + i)};
            }
            return list;
        }
    }
}

