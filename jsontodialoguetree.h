#ifndef JSONTODIALOGUETREE_H
#define JSONTODIALOGUETREE_H

#include <QObject>
#include <QJsonDocument>
#include <QFile>
#include <QDebug>
#include <QJsonObject>

class JsonToDialogueTree : public QObject {
    Q_OBJECT
    Q_PROPERTY(QJsonObject tree READ getTree)
    Q_PROPERTY(QString filename READ filename WRITE setFilename NOTIFY filenameChanged)
public:
    JsonToDialogueTree();
    QString filename();
    void setFilename(QString filename);
    QJsonObject getTree();

signals:
    void ready();
    void filenameChanged();

private slots:
    void setTree();

private:
    QString m_filename;
    QJsonObject m_tree;
};

#endif // JSONTODIALOGUETREE_H
