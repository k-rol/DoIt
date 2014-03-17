import bb.cascades 1.2

Sheet {
    id: aboutSheet

    Page {
        titleBar: TitleBar {
            title: "About us"
            acceptAction: ActionItem {
                title: "Close"
                onTriggered: {
                    aboutSheet.close()
                }
            }
        }
        Container {
            Label {
                text: "About us..."            
            }
        }
    }
}