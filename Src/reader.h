#ifndef READER_HPP
#define READER_HPP

#include <QObject>

class Reader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString result READ result WRITE setResult NOTIFY resultChanged)
public:
    Reader(QObject * parent = nullptr);

    QString source() const;
    QString result() const;

public slots:
    void setSource(QString source);
    void setResult(QString result);

private slots:
    void updateResult();
signals:
    void sourceChanged(QString source);
    void resultChanged(QString result);

private:
    QString m_source;
    QString m_result;
};

#endif // READER_HPP
