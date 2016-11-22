import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
//    property string baseApiUrl: "http://ec2-54-191-226-108.us-west-2.compute.amazonaws.com/api/"
    property string baseApiUrl: "http://localhost:8000/api/"

    MainForm {
        anchors.fill: parent
        mouseArea.onClicked: {
            Qt.quit();
        }

    }


    HttpRequest {
        id: httpRequest
    }
}
