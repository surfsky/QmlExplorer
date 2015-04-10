import QtQuick 2.0


/**
测试在c++中调用qml中的方法和属性
请查看main.cpp中的相应代码

#include "Calling_QML_Functions.h"
#include <QDebug>

Calling_QML_Functions::Calling_QML_Functions(QmlApplicationViewer *view, QObject *parent) :
    QObject(parent)
{
    m_view = view;
    m_view->setMainQmlFile(QLatin1String("qml/Example/CallingQMLFunctions.qml"));
    connect((QObject*)(m_view->rootObject()), SIGNAL(qmlSignal(QString)), this, SLOT(onQmlSignal(QString)));
}

void Calling_QML_Functions::onQmlSignal(const QString &msg)
{
    qDebug() << "onQmlSignal()============";
    qDebug() << msg;
}


void Calling_QML_Functions::invoke(const char *funcion, QVariant &returnedValue, const QVariant &value)
{
    QMetaObject::invokeMethod((QObject*)(m_view->rootObject()), funcion, Q_RETURN_ARG(QVariant, returnedValue), Q_ARG(QVariant, value));
}



*/
Item {
    property string name : 'MyNameIsExample'
    function say(text) {
        console.log("You said " + text);
        return 'ok';
    }
}
