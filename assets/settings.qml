import bb.cascades 1.2

Sheet {
    id: mySheet
    Page {
        titleBar: TitleBar {
            title: "Settings"
             kind: TitleBarKind.Default
            acceptAction: ActionItem {
                title: "Save"
                onTriggered: {
                    doitsettings.setSettings(objectName, passwordField.text)
                    doitsettings.syncSettings()
                    mySheet.close()
                }

            }
            dismissAction: ActionItem {
                title: "Cancel"
                onTriggered: {
                    mySheet.close()
                }
            }

        }
        Container {
            
            Label {
                text: qsTr("Enter your GoPro's WiFi Password:")
                verticalAlignment: VerticalAlignment.Top
            }
            
            TextField {
                id: passwordField
                input.masking: TextInputMasking.Masked
                hintText: qsTr("password")
                text: doitsettings.getSettings(objectName);
                objectName: "password"
                verticalAlignment: VerticalAlignment.Top
                maxWidth: 560.0
                inputMode: TextFieldInputMode.Password
            }
            topPadding: 40
            leftPadding: 10

        }
    }
    
}