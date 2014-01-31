import bb.cascades 1.2

Sheet {
    id: mySheet
    Page {
        titleBar: TitleBar {
            title: "Settings"
             kind: TitleBarKind.Default
            acceptAction: ActionItem {
                title: "Save"

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
                input.masking: TextInputMasking.Masked
                hintText: qsTr("password")
                verticalAlignment: VerticalAlignment.Top
                maxWidth: 560.0
                inputMode: TextFieldInputMode.Password
            }
            topPadding: 40
            leftPadding: 10

        }
    }
    
}