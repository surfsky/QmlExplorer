#include <QFile>
#include <QObject>
#include <QTextStream>
#include <QFile>


/*!
 * \brief 文件操作。扩展qml，继承自QObject，可作为上下文属性来使用
 */
class FileIO : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(QString source
               READ source
               WRITE setSource
               NOTIFY sourceChanged)
    explicit FileIO(QObject *parent = 0);

    Q_INVOKABLE QString read()
    {
        if (mSource.isEmpty()){
            emit error("source is empty");
            return QString();
        }

        QFile file(mSource);
        QString fileContent;
        if ( file.open(QIODevice::ReadOnly) ) {
            QString line;
            QTextStream t( &file );
            do {
                line = t.readLine();
                fileContent += line;
             } while (!line.isNull());

            file.close();
        } else {
            emit error("Unable to open the file");
            return QString();
        }
        return fileContent;
    }

    Q_INVOKABLE bool write(const QString& data)
    {
        if (mSource.isEmpty())
            return false;

        QFile file(mSource);
        if (!file.open(QFile::WriteOnly | QFile::Truncate))
            return false;

        QTextStream out(&file);
        out << data;

        file.close();

        return true;
    }



    QString source() { return mSource; }

public slots:
    void setSource(const QString& source) { mSource = source; }

signals:
    void sourceChanged(const QString& source);
    void error(const QString& msg);

private:
    QString mSource;
};


