#include "reader.h"
#include <QFile>
#include <QDebug>
#include <QDir>

Reader::Reader(QObject * parent) :
    QObject(parent)
{
    m_result.clear();
    m_source.clear();
    connect(this, SIGNAL(sourceChanged(QString)), this, SLOT(updateResult()));
}
QString Reader::source() const
{
    return m_source;
}
QString Reader::result() const
{
    return m_result;
}

void Reader::setSource(QString source)
{
    if (m_source == source)
        return;

    m_source = source;
    emit sourceChanged(source);
}
void Reader::setResult(QString result)
{
    if (m_result == result)
        return;

    m_result = result;
    emit resultChanged(result);
}

void Reader::updateResult()
{
    QFile file(m_source);
    if (file.open(QFile::ReadOnly)) {
        QByteArray data = file.readAll();
        file.close();
        setResult(QString(data));
    } else {
        qDebug() << "Read file "<< file.fileName()<< " failed:" << file.errorString();
    }
}
