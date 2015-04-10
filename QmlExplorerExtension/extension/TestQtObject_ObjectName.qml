/**
测试QtObject.objectName属性
该属性可被c++访问（findChild）
*/
import QtQuick 2.0
Item {
    width: 200; height: 200
    Rectangle {
        anchors.fill: parent
        color: "red"
        objectName: "myRect"  // 供c++代码访问
    }
}

/*
// c++访问指定qml元素
// main.cpp
QQuickView view;
view.setSource(QUrl::fromLocalFile("MyRect.qml"));
view.show();

QQuickItem *item = view.rootObject()->findChild<QQuickItem*>("myRect");
if (item)
    item->setProperty("color", QColor(Qt::yellow));
*/
