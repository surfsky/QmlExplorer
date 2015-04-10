#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QFile>
#include "extension/utils.cpp"
//#include "extension/imageProcessor.h"



int main(int argc, char *argv[])
{
    QApplication app(argc, argv);



    //--------------------------------------
    // 注册qml新组件（供QML中调用）
    // 参见示例：qml/Extension/TestPieChart.qml
    //--------------------------------------
    //qmlRegisterType<PieChart>("Charts", 1, 0, "PieChart");
    //qmlRegisterType<GradientEx>("Charts", 1, 0, "GradientEx");
    //qmlRegisterType<Gradiente>("MisComponentes", 1, 0, "Gradiente");
    //qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");
    //qmlRegisterType<ImageProcessor>("an.qt.ImageProcessor", 1, 0,"ImageProcessor");
    //qmlRegisterType<MyPushButton>("QWidgets", 1, 0, "MyPushButton");

    //--------------------------------------
    // 注册上下文对象（供QML中调用）
    // 参见示例：qml/Extension/TestCallQml.qml
    //--------------------------------------
    QQmlEngine engine;
    QQmlContext *ctx = engine.rootContext();
    Utils u;

    //ctx->setContextProperty("Utils", new Utils(0));
    //ctx->setContextProperty("fonts",  QVariant::fromValue(Utils::getFonts()));
    //ctx->setContextProperty("lists",  QVariant::fromValue(Utils::getStringList()));


    //--------------------------------------
    // 创建QML对象，并操作QML中暴露的方法和属性
    // 参见示例：qml/Extension/TestCallQml.qml
    //--------------------------------------
    // 调用qml对象中的方法
    //QQmlComponent component(&engine, QUrl("qml/Extension/TestCallQml.qml"));
    //QObject *object = component.create(ctx);

    // 调用方法
    //QString retVal;
    //QMetaObject::invokeMethod(object, "say", Qt::DirectConnection,
    //                          Q_RETURN_ARG(QString, retVal),
    //                          Q_ARG(QString, "hello world")
    //                          );

    // 操作属性
    //int n = QMetaObject::indexOfProperty("name");
    //QMetaProperty property = QMetaObject::property(n);
    //QMetaObject::SetProperty(object, "setName", "you name");
    //QVariant v = QMetaObject::ReadProperty(object, "getName");



    //--------------------------------------
    // main
    //--------------------------------------
    QQmlApplicationEngine e;
    e.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
