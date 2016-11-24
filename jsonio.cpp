#include "jsonio.h"

JsonIO::JsonIO(QWidget *parent) {
    //constructor
}

int JsonIO::status() const {
    return m_status;
}

void JsonIO::setStatus(Status s) {
    if (m_status != s) {
        m_status = s;
    }
    emit statusChanged();
}

QJsonObject JsonIO::data() const {
    return m_jsonObject;
}

void JsonIO::setData(QJsonObject data) {
    if (m_jsonObject != data) {
        m_jsonObject = data;
        emit dataChanged();
    }
}

void JsonIO::save(QString fileUrl) {
    //create a json doc from data and validate
    QJsonDocument doc(m_jsonObject);
    if (doc.isNull()) {
        qWarning() << "Error saving json data: Null document";
        setStatus(Error);
        return;
    }

    qDebug() << QString(doc.toJson());

    //convert the fileUrl to a format usable by QFile
    QUrl url(fileUrl);
    QString filename = url.toLocalFile();
    QFile *file = new QFile(filename);

    // IO validation n stuff
    if (!file->open(QIODevice::WriteOnly)) {
        setStatus(Error);
        return;
    }

    QString jsonStr(doc.toJson());
    QTextStream out(file);
    out << jsonStr;

    setStatus(Success);
    emit saved();
}

void JsonIO::load(QString fileUrl) {
    //convert the fileUrl to a format usable by QFile
    QUrl url(fileUrl);
    QString filename = url.toLocalFile();
    QFile *file = new QFile(filename);

    // IO validation n stuff
    if (!file->open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Error loading json data: file does not exist";
        setStatus(Error);
        return;
    }

    //read the data
    QString jsonString;
    jsonString = file->readAll();
    file->close();

    QJsonDocument doc = QJsonDocument::fromJson(jsonString.toUtf8());

    //make sure data isn't empty
    if(doc.isNull()) {
        qWarning() << "Error loading json data: Null document";
        setStatus(Error);
        return;
    }

    setData(doc.object());

    setStatus(Success);
    emit loaded();
}
