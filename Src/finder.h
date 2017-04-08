#ifndef FINDER_H
#define FINDER_H

#include <QObject>
#include <QQmlListProperty>
class Finder : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged)
    Q_PROPERTY(QStringList targets READ targets WRITE setTargets NOTIFY targetsChanged)
    Q_PROPERTY(QString suffix READ suffix WRITE setSuffix NOTIFY suffixChanged)
public:
    explicit Finder(QObject *parent = 0);

    QStringList targets() const;
    QString path() const;
    QString suffix() const;

signals:
    void targetsChanged();
    void pathChanged(QString path);
    void suffixChanged(QString suffix);

public slots:
    void setPath(QString path);
    void setSuffix(QString suffix);
    void setTargets(QStringList targets);
private slots:
    void updateTargets();
    void find(QString path);
private:
    QStringList m_targets;

    QString m_path;

    QString m_suffix;
};

#endif // FINDER_H
