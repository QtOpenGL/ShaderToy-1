#include "finder.h"
#include <QDir>
#include <QDebug>
Finder::Finder(QObject *parent) : QObject(parent)
{
    qDebug() << "construct";
    connect(this, SIGNAL(pathChanged(QString)), this, SLOT(updateTargets()));
}
void Finder::find(QString path)
{
    QDir dir(path);
    for (auto i : dir.entryInfoList()) {
        if (i.isFile()) {
            if (i.suffix().toLower() == suffix()) {
                m_targets.append(i.absoluteFilePath());
            }
        } else if (i.isDir()) {
            if (i.fileName() == "." || i.fileName() == "..") continue;
            find(i.absoluteFilePath());
        }
    }
}
void Finder::updateTargets()
{
    QDir dir(m_path);
    if (!dir.exists()) {
        qDebug() << "dir not exist";
        return ;
    }
    m_targets.clear();
    find(dir.absolutePath());
    qDebug() <<"targets: " <<  m_targets;
    emit targetsChanged();
    emit suffixChanged(QString("123"));
}

void Finder::setPath(QString path)
{
    if (m_path == path)
        return;

    m_path = path;
    emit pathChanged(path);
}

QStringList Finder::targets() const
{
    return m_targets;
}

QString Finder::path() const
{
    return m_path;
}
QString Finder::suffix() const
{
    return m_suffix;
}
void Finder::setSuffix(QString suffix)
{
    if (m_suffix == suffix)
        return;

    m_suffix = suffix;
    emit suffixChanged(suffix);
}

void Finder::setTargets(QStringList targets)
{
    if (m_targets == targets)
        return ;

    m_targets = targets;
    emit targetsChanged();
}