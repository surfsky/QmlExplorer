#ifndef QQUICKGRADIENTEX_H
#define QQUICKGRADIENTEX_H
#include "qquickrectangle_p.h"

#include <QQuickItem>
#include <QtQuick/QQuickPaintedItem>
#include <QColor>


// 自定义渐变组件
// 支持渐变类别：linear线性渐变、radial辐射渐变、conical角度渐变
// 未完全实现，不知道怎么把GradientStop 加进去
class GradientEx : public QQuickPaintedItem
{
    Q_OBJECT
    //Q_PROPERTY(QQmlListProperty<QQuickGradientStop> stops READ stops)
    Q_PROPERTY(QString type READ type WRITE setType)
    Q_PROPERTY(int angle READ angle WRITE setAngle)

public:
    GradientEx(QQuickItem *parent = 0);
    void paint(QPainter *painter);

    // 渐变类别
    QString type(){return m_type;}
    void setType(QString type){m_type = type;}

    // 渐变角度（仅线性渐变可用）
    int angle(){return m_angle;}
    void setAngle(int angle){m_angle = angle;}

    // 渐变点
    //QQmlListProperty<QQuickGradientStop> stops();


private:
    QString m_type = "";
    int m_angle = 0;
};

#endif // QQUICKGRADIENTEX_H
