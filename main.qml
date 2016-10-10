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

    DialogueTree {
        id: tree

        onReady: {
            var properties = {
                "nodeId": 1,
                "previous": 0,
                "type"  : "choice",
                "msg" : "Hello World!"
            }
            //sample test node
            createNode(properties)

            var jsonObj = exportTreeToJson()
            printTree(jsonObj)

            //send in http request
            var url = baseApiUrl + "exportDialogue"
            var filename = "SampleConversation1"
            var prams = "jsonStr=" + JSON.stringify(jsonObj) + "&filename=" + filename
            httpRequest.post(url, prams,
                            function (reply) { //success
                                //do stuff with the reply
                                console.log(reply.responseText)
                            },
                            function (reply){ //fail
                                console.log("HttpModel :: Failed POST request")
                            })
        }
    }

    HttpRequest {
        id: httpRequest
    }
}
