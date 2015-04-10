#include <QObject>
#include <QUuid>
#include <QFontDatabase>
#include <QStringList>
#include <QScreen>
#include <QFont>
#include <QClipboard>
#include <QFontMetrics>
#include <QApplication>

/*!
 * 辅助工具类。非可视元素，作为上下文属性来使用
 */
class Utils : public QObject
{
    Q_OBJECT

public:
    //----------------------------------------
    // 构造函数
    //----------------------------------------
    Utils(QObject *parent = 0) : QObject(parent){}


    //----------------------------------------
    // 剪贴板处理
    //----------------------------------------
    Q_INVOKABLE static void setClipboardImage(QImage image)
    {
        QClipboard *clipboard = QApplication::clipboard();
        clipboard->setImage(image);
    }

    Q_INVOKABLE static void setClipboardText(QString string)
    {
        QClipboard *clipboard = QApplication::clipboard();
        clipboard->setText(string);
    }


    //----------------------------------------
    // misc
    //----------------------------------------
    // 获取字体列表
    Q_INVOKABLE static QStringList getFontFamilies()
    {
        QFontDatabase database;
        return database.families();
    }

    // 获取字符串数据
    Q_INVOKABLE static QStringList getStringList()
    {
        QStringList dataList;
        dataList.append("Item 1");
        dataList.append("Item 2");
        dataList.append("Item 3");
        dataList.append("Item 4");
        return dataList;
    }

    // 生成GUID
    Q_INVOKABLE static QString generateGUID()
    {
        return QUuid::createUuid().toString();
    }

    //----------------------------------------
    // 尺寸处理
    //----------------------------------------
    // 点大小转化为像素大小
    Q_INVOKABLE static int getPixelSize(int pointSize)
    {
        QScreen *screen = qApp->primaryScreen();
        return pointSize * screen->logicalDotsPerInch();
    }

    // 获取字体高度
    Q_INVOKABLE static int getFontHeight(int pointSize)
    {
        QFont font = qApp->font();
        font.setPointSize(pointSize);
        QFontMetrics fm(font);
        return fm.height();
    }

    // 获取文字宽度
    Q_INVOKABLE static int getTextWidth(QString text, int pointSize)
    {
        QFont font = qApp->font();
        font.setPointSize(pointSize);
        QFontMetrics fm(font);
        return fm.width(text);
    }

};
