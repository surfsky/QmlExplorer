#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QQmlComponent>
#include <QLabel>
#include "./QmlExtension/Highlighter/SyntaxHighlighter.h"

int main(int argc, char *argv[])
{
    // application
    QApplication app(argc, argv);
    app.setApplicationName("QML Explorer");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("surfsky.com");
    app.setOrganizationDomain("com.surfsky.qmlexplorer");

    // regist
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 0, "SyntaxHighlighter");

    // 主窗体
    QQuickView view;
    //view.setSource(QUrl("qrc:/Qml/QmlExplorer.qml"));
    view.setSource(QUrl("qrc:/Qml/QmlExplorerMobile.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();
    return app.exec();
}
