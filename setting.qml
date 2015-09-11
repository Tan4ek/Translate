import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.3
import "logic.js" as Logic

Window{
    id: window1
    width: 200
    height: 100

    function writeChange(){
        var toWrite = "";
        for(var key in settings){
            toWrite += "" + key + "=" + textFieldKey.text + "\n"
        }
        Logic.writeFile(toWrite);
        Logic.key = textFieldKey.text;
        console.log(Logic.key);
    }

    Column {
        id: column1
        spacing: 5
        anchors.fill: parent

        Column {
            id: column2
            spacing: 5

            Row {
                id: row2
                x: 5
                width: 190
                height: 30
                spacing: 10

                Label {
                    id: labelKey
                    text: qsTr("Key: ")
                    transformOrigin: Item.Center
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    id: textFieldKey
                    width: 140
                    anchors.verticalCenter: parent.verticalCenter
                    placeholderText: Logic.key;
                }
            }

            Row {
                id: row3
                x: 5
                width: 190
                height: 30

                Label {
                    id: label2
                    text: qsTr("Label")
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        Row {
            id: row1
            width: 200
            height: 30
            spacing: 10
            layoutDirection: Qt.RightToLeft

            Button {
                id: buttonSave
                x: 111
                text: qsTr("Save")
                onClicked: {
                    writeChange();
                    window1.close();
                }
            }

            Button {
                id: buttonCancel
                text: qsTr("Cancel")
                onClicked: {
                    window1.close();
                }
            }
        }
    }
}

