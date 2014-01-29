import bb.cascades 1.2
import Network.GetterRequest 1.0

TabbedPane {
    id: thisTab
    Tab {
        title: "first tab"
        content: Page {
            id: startpage
            Menu.definition:  MenuDefinition {
                helpAction: HelpActionItem {
                    
                }
                settingsAction: SettingsActionItem {
                    onTriggered: {
                    
                    }
                }
            }
            attachedObjects: [
                ComponentDefinition {
                    id: settingPage
                    source: "settings.qml"
                }
            ]
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
                    text: qsTr("Power On") + Retranslate.onLocaleOrLanguageChanged
                    
                    onClicked: {
                        //myTextArea.text="Turned On"
                        getThis.GetRequest(passwordField.text, "PW", "01");
                        
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
                    text: qsTr("Power Off") + Retranslate.onLocaleOrLanguageChanged
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

    }
    Tab {
        title: "second"
        content: Page {
            Container {
                Label {
                    // Localized text with the dynamic translation and locale updates support
                    text: qsTr("DoIt GoPro") + Retranslate.onLocaleOrLanguageChanged
                    textStyle.base: SystemDefaults.TextStyles.BigText
                }    
            }
        }

    }

}
