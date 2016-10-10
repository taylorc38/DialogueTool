import QtQuick 2.0

Item {
    id: root

    property url targetUrl
    property int status
    property string textReply
    signal requestFinished

    onTargetUrlChanged: resetData()

    function resetData() {
        textReply = ""
        status = 0
    }

    function httpRequest(url, operation, prams, callback, callbackError) {
        var doc = new XMLHttpRequest();
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                // TODO: read headers if needed
            } else if (doc.readyState === XMLHttpRequest.DONE) {
                root.status = doc.status
                root.textReply = doc.responseText
                if (doc.status === 200)
                    callback(doc)
                else
                    callbackError(doc)
                root.requestFinished()
            }
        }
        doc.open(operation, url, true);
        if (operation ==="POST") {
            doc.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            doc.send(prams)
        } else {
            doc.send();

        }
    }

    function get(url, callBack, errorCallback) {
        targetUrl = url
        httpRequest(url, "GET", "", callBack, errorCallback)
    }

    function post(url, prams, callBack, errorCallback) {
        console.log("::DEBUG::http post:" + url + " :: " +prams)
        targetUrl = url
        httpRequest(url, "POST", prams, callBack, errorCallback)
    }

}
