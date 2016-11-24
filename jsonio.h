#ifndef JSONIO_H
#define JSONIO_H

#include <QFile>
#include <QDataStream>
#include <QIODevice>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>
#include <QUrl>
#include <QTextStream>

class JsonIO : public QObject {
    Q_OBJECT
    Q_PROPERTY(int status READ status NOTIFY statusChanged)
    Q_PROPERTY(QJsonObject data READ data WRITE setData NOTIFY dataChanged)

public:
    enum Status { Success = 0, Error };

    JsonIO(QWidget *parent = 0);
    Q_INVOKABLE void save(QString fileUrl);
    Q_INVOKABLE void load(QString fileUrl);
    int status() const;
    void setStatus(Status);
    QJsonObject data() const;
    void setData(QJsonObject data);


signals:
    void statusChanged();
    void dataChanged();
    void saved();
    void loaded();
private:
    Status m_status;
    QJsonObject m_jsonObject;
};

#endif // JSONIO_H
