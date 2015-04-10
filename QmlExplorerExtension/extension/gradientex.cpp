#include "gradientex.h"
#include <QLinearGradient>
#include <QPainter>
#include <QtCore/qmath.h>

GradientEx::GradientEx(QQuickItem *parent)
    : QQuickPaintedItem(parent)
{
    m_type = "linear";
}

/*
void GradientEx::paint(QPainter *painter)
{
    QPen pen(Qt::green, 2);
    painter->setPen(pen);
    painter->setRenderHints(QPainter::Antialiasing, true);
    painter->drawPie(boundingRect().adjusted(1, 1, -1, -1), 90 * 16, 290 * 16);
}
*/


void GradientEx::paint(QPainter *painter)
{
    QRectF r = boundingRect().adjusted(1, 1, -1, -1);
    int w = r.width();
    int h = r.height();
    int x1 = r.x();
    int y1 = r.y();

    //线性渐变
    if (m_type == "linear")
    {
        // 根据angle计算出渐变起点和终点的坐标
        QPointF startPoint = r.topLeft();
        QPointF endPoint = r.bottomRight();

        //创建了一个QLinearGradient对象实例，参数为起点和终点坐标，可作为颜色渐变的方向
        QLinearGradient linearGradient(startPoint, endPoint);
        linearGradient.setColorAt(0.0, Qt::green);
        linearGradient.setColorAt(0.2, Qt::white);
        linearGradient.setColorAt(0.4, Qt::blue);
        linearGradient.setColorAt(0.6, Qt::red);
        linearGradient.setColorAt(1.0, Qt::yellow);
        painter->setBrush(QBrush(linearGradient));
        painter->drawRect(r);
        return;
    }

    //辐射渐变
    if (m_type == "radial")
    {
        // 计算出渐变起点和终点的坐标
        QPointF startPoint = QPointF(x1+w/2.0, y1+h/2.0);
        int radius = qSqrt(w*w + h*h)/2.0;

        //创建了一个QRadialGradient对象实例，参数分别为中心坐标，半径长度和焦点坐标,如果需要对称那么中心坐标和焦点坐标要一致
        QRadialGradient radialGradient(startPoint, radius, startPoint);
        radialGradient.setColorAt(0,   Qt::green);
        radialGradient.setColorAt(0.4, Qt::blue);
        radialGradient.setColorAt(1.0, Qt::yellow);
        painter->setBrush(QBrush(radialGradient));
        painter->drawRect(r);
        return;
    }


    //弧度渐变
    if (m_type == "conical")
    {
        // 计算出渐变起点和终点的坐标
        QPointF startPoint = QPointF(x1+w/2.0, y1+h/2.0);
        int angle = m_angle;

        //创建了一个QConicalGradient对象实例，参数分别为中心坐标和初始角度
        //设置渐变的颜色和路径比例
        QConicalGradient conicalGradient(startPoint, angle);
        conicalGradient.setColorAt(0,   Qt::green);
        conicalGradient.setColorAt(0.2, Qt::white);
        conicalGradient.setColorAt(0.4, Qt::blue);
        conicalGradient.setColorAt(0.6, Qt::red);
        conicalGradient.setColorAt(0.8, Qt::yellow);
        conicalGradient.setColorAt(1.0, Qt::green);
        painter->setBrush(QBrush(conicalGradient));
        painter->drawRect(r);
        return;
    }
}
