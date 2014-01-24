import bb.cascades 1.2
import Network.GetterRequest 1.0

Page {
    Container {
        
        Label {
            // Localized text with the dynamic translation and locale updates support
            text: qsTr("DoIt GoPro") + Retranslate.onLocaleOrLanguageChanged
            textStyle.base: SystemDefaults.TextStyles.BigText
        }
        TextField {
            id: passwordField
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
                    onCommandSent: {
                        commandArea.text = commandSent;
                    }
                    onResponseReceived: {
                        responseArea.text = info;
                    }
                }
            ]
        }
        Button {
            text: "Power Off"
            onClicked: {
                commandArea.text="Turned Off"                
            }
        }
        TextArea {
            id: commandArea
            text: "Command here."
        }
        TextArea {
            id: responseArea
            text: "Response here."
        }
    }
}
