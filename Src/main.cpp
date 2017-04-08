#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "reader.h"
#include "finder.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Reader>("Reader", 1, 0, "Reader");
    qmlRegisterType<Finder>("Finder", 1, 0, "Finder");

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/Qml/main.qml")));

    return app.exec();
}
