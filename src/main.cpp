#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "qmlenvironmentvariable.h"
#include <QQmlEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<QmlEnvironmentVariable>("EnvironmentVariables", 1, 0, "QmlEnvironmentVariable");
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
