#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQuickView>
#include <QDir>
#include <QQmlFileSelector>

#include "jsontodialoguetree.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<JsonToDialogueTree>("JsonToDialogueTree", 1, 0, "JsonToDialogueTree");


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
