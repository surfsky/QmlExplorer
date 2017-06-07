import QtQuick 2.0


/***
页面基类
    属性：title
    信号：
        redirec: 供主窗口处理，用于页面跳转
        back: 返回键
*/
Rectangle {
    focus: true;

    property string title;
    signal redirect(string url);
    signal back;

    Component.onCompleted:   console.log(title + ' create');
    Component.onDestruction: console.log(title + ' destruction');
    //Component.onDestroyed:   console.log(title + ' destroyed');

    // 返回键
    Keys.onBackPressed:   {console.log('backPressed'); back();}
    Keys.onEscapePressed: {console.log('escapePressed'); back();}
    Keys.onLeftPressed:   {console.log('leftPressed'); back();}
}
