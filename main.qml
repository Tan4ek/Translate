import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtWebKit 3.0
import "logic.js" as Logic
import FileIO 1.0
import QtMultimedia 5.5

ApplicationWindow {
    id: mainWindow
    x: 10
    y: 10
    width: 400
    height: 400
    visible: true
    title: "Translate"

    property var setting: Qt.createComponent("setting.qml");

    menuBar: MenuBar {
            Menu {
                title: "Настройки"
                MenuItem {
                    text: "Настройки"
                    onTriggered: {
                        var vin = mainWindow.setting.createObject();
                        vin.show();
                    }
                }
            }
        }

    Component.onCompleted: {
        Logic.synchronization(mainWindow, file);
    }

    FileIO {
        id: file
        source: "";
    }

    function setComboxModel(diction){
        var arrayLangv = [];
        for(var i in diction){
            arrayLangv.push(diction[i].name);
        }
        arrayLangv.sort();
        comboBoxLeft.model = arrayLangv;
        comboBoxLeft.currentIndex = arrayLangv.indexOf(diction['ru'].name);
        comboBoxRight.model = arrayLangv;
        comboBoxRight.currentIndex = arrayLangv.indexOf(diction['en'].name);
    }

    function setTranslateText(text){
        textAreaOutput.text = text;
    }

    Column {
        id: column1
        anchors.topMargin: 0
        spacing: 2
        anchors.fill: parent

        Row {
            id: row1
            height: 70
            visible: true
            spacing: 5
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            ComboBox {
                id: comboBoxLeft
                width: 110
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                visible: true
                focus: true
                onCurrentTextChanged: {
                    for(var current in Logic.getDict()){
                        if(Logic.getDict()[current].name === currentText){
                            var inicial = Logic.getDict()[current].directions;
                            console.log(inicial);
                            var listCountrys = [];
                            inicial.forEach(function(inicCountry){
                                console.log(Logic.getDict()[inicCountry].name, ' of ', inicCountry)
                                listCountrys.push(Logic.getDict()[inicCountry].name)
                            });
                            console.log(' ')
                            listCountrys.sort();

                            comboBoxRight.model = listCountrys;
                        }
                    }
                }
                Keys.onPressed: {
                    console.log(event.text);
                }
                onPressedChanged: {

                }
            }

            ComboBox {
                id: comboBoxRight
                width: 110
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 5
                visible: true
            }

            Button {
                text: qsTr("Перевести!")
                anchors.right: buttonChangeDirection.left
                anchors.rightMargin: 10
                anchors.left: comboBoxLeft.right
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5

                onClicked:{
                    Logic.tranlate(textAreaInput.text,
                                   Logic.getByFullName(comboBoxLeft.currentText) +
                                   "-" +
                                   Logic.getByFullName(comboBoxRight.currentText));
                    console.log("onCLick" ,Logic.getString());
                }
            }

            Button {
                id: buttonChangeDirection
                x: 217
                width: 60
                text: qsTr("")
                iconSource: "file:///home/ssr/Qt_project/Translate/changeDiraction.png"
                anchors.right: comboBoxRight.left
                anchors.rightMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                onClicked: {
                    var from = comboBoxRight.currentText;
                    var to = comboBoxLeft.currentText;
                    comboBoxLeft.currentIndex = comboBoxLeft.model.indexOf(from);
                    comboBoxRight.currentIndex = comboBoxRight.model.indexOf(to);
                }
            }
        }

        Column {
            id: column2
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: row1.bottom
            anchors.topMargin: 0

            TextArea {
                id: textAreaInput
                height: column2.height/2
                font.pointSize: 16
                font.family: "Times New Roman"
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                wrapMode: Text.Wrap
            }

            TextArea {
                id: textAreaOutput
                font.pointSize: 16
                font.family: "Times New Roman"
                anchors.top: textAreaInput.bottom
                anchors.topMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
            }
        }
    }
}

