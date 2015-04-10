#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QQmlComponent>
#include <QLabel>
#include "./QmlExtension/Highlighter/SyntaxHighlighter.h"
//#include "mainwindow.h"
//#defing QT_NO_DEBUG_OUTPUT

int main(int argc, char *argv[])
{
    /*
    QApplication app(argc, argv);
    MainWindow mainWindow(QUrl("../qml/QmlExplorer.qml"));
    mainWindow.show();
    return app.exec();
    */

    // application
    QApplication app(argc, argv);
    app.setApplicationName("QML Explorer");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("surfsky.com");
    app.setOrganizationDomain("com.surfsky.qmlexplorer");

    // regist
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 0, "SyntaxHighlighter");

    // 主窗体
    QUrl url = QUrl("./qml/QmlExplorerMobile.qml");
    QQuickView view;
    view.setSource(url);
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();
    return app.exec();
}
