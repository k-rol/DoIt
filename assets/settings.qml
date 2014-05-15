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
                    Settings.setSettings(passwordField.objectName, passwordField.text)
                    //Settings.syncSettings()
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
                text: Settings.getSettings("password", "")
                
                objectName: "password"
                verticalAlignment: VerticalAlignment.Top
                maxWidth: 560.0
                inputMode: TextFieldInputMode.Password
            }
            topPadding: 40
            leftPadding: 10

            Container {
                //Todo: fill me with QML
                DropDown {
                    topPadding: 20
                    id: themeDropDown
                    title: qsTr("Theme Selection:") + Retranslate.onLocaleOrLanguageChanged
                    
                    Option {
                        text: qsTr("Bright") + Retranslate.onLocaleOrLanguageChanged
                        value: VisualStyle.Bright
                    }
                    
                    Option {
                        text: qsTr("Dark") + Retranslate.onLocaleOrLanguageChanged
                        value: VisualStyle.Dark
                    }
                    onSelectedOptionChanged: {
                        Settings.setSettings("theme", VisualStyle.Bright == themeDropDown.selectedValue ? "bright" : "dark");
                    }
                }
                onCreationCompleted: {
                    var theme = Settings.getSettings("theme", VisualStyle.Bright == themeDropDown.selectedValue ? "bright" : "dark");
                    themeDropDown.setSelectedIndex("bright" == theme ? 0 : 1);
                    console.debug("VISUAL THEME")
                    console.debug(theme)
                }
            }
        }
        
    }
    
}