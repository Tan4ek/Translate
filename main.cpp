#include <QGuiApplication>
#include <QQmlEngine>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <fileio.h>
#include <QDebug>

int main(int argc, char *argv[])
{
    qDebug() << qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

