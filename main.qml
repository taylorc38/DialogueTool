import QtQuick 2.4
import QtQuick.Window 2.2
import JsonIO 1.0

Window {
    id: root

    height: 800
    width: 1200
    visible: true

    //    property string baseApiUrl: "http://ec2-54-191-226-108.us-west-2.compute.amazonaws.com/api/"
        property string baseApiUrl: "http://localhost:8000/api/"

    Component.onCompleted: {
        stateGroup.state = "browse"
    }

    StateGroup {
        id: stateGroup

        states: [
            State {
                name: "browse"
                PropertyChanges {
                    target: fileBrowser
                    visible: true
                }
                PropertyChanges {
                    target: viewer
                    visible: false
                }
            },
            State {
                name: "treeView"
                PropertyChanges {
                    target: fileBrowser
                    visible: false
                }
                PropertyChanges {
                    target: viewer
                    visible: true
                }
            }
        ]
    }

    JsonIO {
        id: io

    }

    Item {
        id: fileBrowser

        anchors.fill: parent

        Rectangle {
            anchors.centerIn: parent
            width: txt.width + 20
            height: 100
            border.color: "black"

            Text {
                id: txt

                anchors.centerIn: parent
                text: "sampleConversation.json"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stateGroup.state = "treeView"
                }
            }
        }
    }

    Item {
        id: viewer

        anchors.fill: parent
        visible: false

        Header {
            id: header

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: 50

            onBrowse: {
                stateGroup.state = "browse"
            }
        }

        TreeViewer {
            id: view

            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: details.top
                margins: 10
            }
        }

        DetailsPanel {
            id: details

            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }

        DialogueTree {
            id: tree

            filename: ":/sampleConversation.json"
        }
    }
//    HttpRequest {
//        id: httpRequest
//    }
}
