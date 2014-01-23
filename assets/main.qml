import bb.cascades 1.2
import Network.GetterRequest 1.0

Page {
    Container {
        //Todo: fill me with QML
        Label {
            // Localized text with the dynamic translation and locale updates support
            text: qsTr("GoPro App") + Retranslate.onLocaleOrLanguageChanged
            textStyle.base: SystemDefaults.TextStyles.BigText
        }
        TextField {
            id: myTextField
            text: "GoPro Password here"
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
        }
        Button {
            text: "Power On"
            onClicked: {
                //myTextArea.text="Turned On"
                getThis.GetRequest();
            }
            attachedObjects: [
                GetterRequest {
                    id: getThis
                    onComplete2: {
                        myTextArea.text = commandSent;
                    }
                    onComplete: {
                        //myTextArea.text = info;
                    }
                }
            ]
        }
        Button {
            text: "Power Off"
            onClicked: {
                myTextArea.text="Turned Off"                
            }
        }
        TextArea {
            id: myTextArea
            text: "Enter text above then click button to insert the text here. MOTHERFUCKER"
        }
    }
}
