#include <QtQuick/QQuickPaintedItem>
#include <QtQuick>


/*!
 * \brief 椭圆。自定义Qml组件，继承自QQuickPaintedItem，自绘外观
 */
class MyEllipse : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor)

public:
    MyEllipse(QQuickItem *parent=0) :
        QQuickPaintedItem(parent)
    {
    }

protected:
    QColor color() const
    {
        return m_color;
    }

    void setColor(const QColor &color)
    {
        m_color = color;
    }

    void paint(QPainter *painter)
    {
        QPen pen(m_color, 2);
        painter->setPen(pen);
        painter->setRenderHints(QPainter::Antialiasing, true);
        painter->drawEllipse(boundingRect());
        //painter->drawPie(boundingRect().adjusted(1, 1, -1, -1), 90 * 16, 290 * 16);
    }


private:
    QColor m_color;
};



