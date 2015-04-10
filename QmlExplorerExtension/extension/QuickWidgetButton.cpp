#include <QQmlExtensionPlugin>
#include <QtQuick>
#include <QGraphicsProxyWidget>
#include <QPushButton>
#include <QDebug>


/**
将widget导出给qml使用（继承自 QGraphicsProxyWidget）
qml调用
    import "QWidgets" 1.0
    MyPushButton  {
        id: button1
        x: margin; y: margin
        text: "Right"
        transformOriginPoint: Qt.point(width / 2, height / 2)
        onClicked: window.state = "right"
    }
*/
class MyPushButton : public QGraphicsProxyWidget
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)

public:
    MyPushButton(QGraphicsItem* parent = 0)
        : QGraphicsProxyWidget(parent)
    {
        widget = new QPushButton("MyPushButton");
        widget->setAttribute(Qt::WA_NoSystemBackground);
        setWidget(widget);

        QObject::connect(widget, SIGNAL(clicked(bool)), this, SIGNAL(clicked(bool)));
    }

    QString text() const
    {
        return widget->text();
    }

    void setText(const QString& text)
    {
        if (text != widget->text()) {
            widget->setText(text);
            emit textChanged();
        }
    }

Q_SIGNALS:
    void clicked(bool);
    void textChanged();

private:
    QPushButton *widget;
};

// 暴露为插件
class QWidgetsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
public:
    void registerTypes(const char *uri)
    {
        qmlRegisterType<MyPushButton>(uri, 1, 0, "MyPushButton");
    }
};

//#include "qwidgets.moc"
Q_EXPORT_PLUGIN2(qmlqwidgetsplugin, QWidgetsPlugin);
