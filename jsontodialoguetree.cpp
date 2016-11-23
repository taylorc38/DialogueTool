#include "jsontodialoguetree.h"

JsonToDialogueTree::JsonToDialogueTree() {
    QObject::connect(this, SIGNAL(filenameChanged()),
                     this, SLOT(setTree()));
    setTree();
}

QString JsonToDialogueTree::filename() {
    return m_filename;
}

void JsonToDialogueTree::setFilename(QString filename){
    m_filename = filename;
    emit filenameChanged();
}

QJsonObject JsonToDialogueTree::getTree() {
    return m_tree;
}

void JsonToDialogueTree::setTree() {

    QString jsonString;
    QFile *file = new QFile(m_filename);
    file->open(QIODevice::ReadOnly | QIODevice::Text);
    jsonString = file->readAll();
    file->close();

    QJsonDocument sd = QJsonDocument::fromJson(jsonString.toUtf8());
    QJsonObject tree = sd.object();

    m_tree = tree;

    emit ready();
}
