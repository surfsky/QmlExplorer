#ifndef WINMESSAGE_H
#define WINMESSAGE_H

#include <QObject>

class WinMessage : public QObject
{
    Q_OBJECT
public:
    explicit WinMessage(QObject *parent = 0);
    ~WinMessage();

signals:

public slots:
};

#endif // WINMESSAGE_H
