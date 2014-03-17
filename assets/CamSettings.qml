import bb.cascades 1.2

Page {
    Container {
        Label {
            // Localized text with the dynamic translation and locale updates support
            text: qsTr("Camera Settings") + Retranslate.onLocaleOrLanguageChanged
            textStyle.base: SystemDefaults.TextStyles.BigText
        }
        Container {
            
        }
            
    }
}
