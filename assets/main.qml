import bb.cascades 1.2
import Network.GetterRequest 1.0
import bb.multimedia 1.0

TabbedPane {
    id: thisTab
    Menu.definition:  MenuDefinition {
        helpAction: HelpActionItem {
        
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                settings.open()
            }
        }
    }
    Tab {
          
        title: "first tab"
        content: Page {
            id: startpage
            attachedObjects: [
                Settings {
                    id: settings
                    peekEnabled: false

                }
            ]
            Container {
                
                Label {
                    id: titlegopro
                    // Localized text with the dynamic translation and locale updates support
                    text: qsTr("DoIt GoPro") + Retranslate.onLocaleOrLanguageChanged
                    textStyle.base: SystemDefaults.TextStyles.BigText
                }
                TextField {
                    id: oldpasswordField
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    hintText: "GoPro Password here"
                    visible: false
                }
                Button {
                    text: qsTr("Power On") + Retranslate.onLocaleOrLanguageChanged
                    
                    onClicked: {
                        
                        getThis.GetRequest(doitsettings.getSettings("password"), "PW", "01");
                        
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
                        getThis.GetRequest(doitsettings.getSettings("password"), "PW", "00")                
                    }
                }
                TextArea {
                    id: commandArea
                    text: "Command here."
                }
                TextArea {
                    id: responseArea
                    text: "Response here."
                    onTextChanged: {
                        activeFrame.update(responseArea.text)
                    }

                }
            }
        }

    }
    Tab {
        title: "Cam Settings"
        content: Page {
            Container {
                    Label {
                        // Localized text with the dynamic translation and locale updates support
                        text: qsTr("Camera Settings") + Retranslate.onLocaleOrLanguageChanged
                        textStyle.base: SystemDefaults.TextStyles.BigText
                    }    
            }
        }

    }
    
    Tab {
        title: "live"
        content: NavigationPane {
            peekEnabled: false
            backButtonsVisible: true
            Page {
                titleBar: TitleBar {
                    title: "Live Preview"

                }
                

            }

        }
    }
    onCreationCompleted: {
      Application.thumbnail.connect(onMinimized)
      }
	function onMinimized()
	{
        activeFrame.update(responseArea.text)
    }
}
