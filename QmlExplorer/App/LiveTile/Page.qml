import QtQuick 2.0


/**
页面基类（包含一个exit信号）
*/
Rectangle {
    width: 100
    height: 62

    signal exit(Item tag);
}
