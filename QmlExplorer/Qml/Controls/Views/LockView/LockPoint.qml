import QtQuick 2.0


/**
锁屏密码点
    默认无底色
    手指头按着路过该控件
        如果已经锁定，不允许再锁定
        如果没有锁定，锁定变底色
*/
Rectangle {
    id: root
    width: 100
    height: width
    radius: width/2
    border.width: 1
    border.color: 'grey'

    // 属性
    property point center : Qt.point(x+width/2, y+width/2);
    property int lockId : 0;
    property bool locked : false;
    onLockedChanged: {root.color = locked ? 'lightblue' : 'transparent';}
}

