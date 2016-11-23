import QtQuick 2.0

Row {
    id: root

    property alias title: title
    property alias textEdit: edit
    property alias titleText: title.text
    property alias textEditContentHeight: edit.contentHeight
    property alias content: edit.text
    property alias textEditWidth: edit.width

    spacing: 10

    signal textChanged(string text)

    Label {
        id: title
        textSize: 20
    }

    Rectangle {
        width: edit.width
        height: parent.height
        color: "#D3D3D3"

        TextEdit {
            id: edit

            width: 100
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            font {
                family: "Monospace"
                pixelSize: 16
            }
            wrapMode: TextEdit.Wrap
            selectByMouse: true

            onTextChanged: root.textChanged(text)
        }
    }
}
