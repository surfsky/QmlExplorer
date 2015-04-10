import QtQuick 2.0


/**
一个package可容纳多个delegate展示
    - 用 Package.name 来区分
    - 用 model.parts.name 来调用
*/
Package {
    id: pack
    Rectangle {
        id: listDelegate;
        Package.name: 'list'
        width: parent.width;
        height: 23;
        color: 'red'
        radius: 5
        border.color: 'white'
        border.width: 2
    }
    Rectangle {
        id: gridDelegate;
        Package.name: 'grid'
        width: parent.width / 2;
        height: 47;
        color: 'green'
        radius: 5
        border.color: 'white'
        border.width: 2
    }
}
