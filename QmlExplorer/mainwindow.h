#include <QMainWindow>
#include <QApplication>
#include <QVBoxLayout>
#include <QLineEdit>
#include <QStatusBar>
#include <QMenuBar>
#include <QMenu>
#include <QAction>
#include <QQmlError>
#include <QQuickView>


class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QUrl url)
    {
        QWidget *centralWidget = new QWidget(this);
        QVBoxLayout *layout = new QVBoxLayout(centralWidget);

        m_quickView = new QQuickView();
        m_quickView->setResizeMode(QQuickView::SizeRootObjectToView);
        connect(m_quickView, SIGNAL(statusChanged(QQuickView::Status)), this, SLOT(quickViewStatusChanged(QQuickView::Status)));
        connect(m_quickView, SIGNAL(sceneGraphError(QQuickWindow::SceneGraphError,QString)), this, SLOT(sceneGraphError(QQuickWindow::SceneGraphError,QString)));
        m_quickView->setSource(url);

        QWidget *container = QWidget::createWindowContainer(m_quickView);
        container->setMinimumSize(m_quickView->size());
        container->setFocusPolicy(Qt::TabFocus);

        layout->addWidget(new QLineEdit(QStringLiteral("A QLineEdit")));
        layout->addWidget(container);
        layout->addWidget(new QLineEdit(QStringLiteral("A QLineEdit")));
        setCentralWidget(centralWidget);

        QMenu *fileMenu = menuBar()->addMenu(tr("File"));
        QAction *quitAction = fileMenu->addAction(tr("Quit"));
        connect(quitAction, SIGNAL(triggered()), qApp, SLOT(quit()));
    }

private slots:
    void quickViewStatusChanged(QQuickView::Status status)
    {
        if (status == QQuickView::Error) {
            QStringList errors;
            foreach (const QQmlError &error, m_quickView->errors())
                errors.append(error.toString());
            statusBar()->showMessage(errors.join(QStringLiteral(", ")));
        }
    }

    void sceneGraphError(QQuickWindow::SceneGraphError error, const QString &message)
    {
        statusBar()->showMessage(message);
    }

private:
    QQuickView *m_quickView;
};
