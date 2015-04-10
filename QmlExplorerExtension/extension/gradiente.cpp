#include "gradiente.h"

Gradiente::Gradiente(QQuickPaintedItem *parent) :
    QQuickPaintedItem(parent)
{
    setFlag(ItemHasContents, true);
}

void Gradiente::paint(QPainter *painter)
{
    //painter->setRenderHints(QPainter::Antialiasing, true);

    float x1 = m_pi.x() * this->width();
    float y1 = m_pi.y() * this->height();
    float x2 = m_pf.x() * this->width();
    float y2 = m_pf.y() * this->height();

    QLinearGradient linearGrad(x1,y1,x2,y2);

    for (int i = 0; i < m_colores.size(); i++) {
        if(i >= m_puntos.size()){
            qWarning() << "El vector de 'colores' y 'puntos' debe tener el mismo tamaño!";
            break;
        }
        else{
            linearGrad.setColorAt(m_puntos.at(i), m_colores.at(i));
        }
    }

    QBrush br(linearGrad);
    painter->fillRect(boundingRect(), br);
}


void Gradiente::setColores(const QList<QString> &cs)
{
    m_colores = cs;
    emit fondoChanged();
}

QList<QString> Gradiente::colores() const
{
    return m_colores;
}

void Gradiente::setPuntos(const QList<qreal> &ps)
{
    m_puntos = ps;
    emit fondoChanged();
}

QList<qreal> Gradiente::puntos() const
{
    return m_puntos;
}

void Gradiente::setPuntoInicial(const QPointF &p)
{
    m_pi = p;
    if(m_pi.x() > 1) m_pi.setX(1);
    if(m_pi.y() > 1) m_pi.setY(1);
    emit fondoChanged();
}

void Gradiente::setPuntoFinal(const QPointF &p)
{
    m_pf = p;
    if(m_pf.x() > 1) m_pf.setX(1);
    if(m_pf.y() > 1) m_pf.setY(1);
    emit fondoChanged();
}

QPointF Gradiente::puntoInicial() const
{
    return m_pi;
}

QPointF Gradiente::puntoFinal() const
{
    return m_pf;
}
