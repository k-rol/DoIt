import bb.cascades 1.2

Sheet {
    id: mySheet
    Page {
        titleBar: TitleBar {
            title: "Settings"
             kind: TitleBarKind.Default
            acceptAction: ActionItem {
                title: "Close"
                onTriggered: {
                    //Settings.syncSettings()
                    mySheet.close()
                }
            }
        }
        Container {
                        
            topPadding: 40
            
            Container {
                //Todo: fill me with QML
                DropDown {
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