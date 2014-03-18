import bb.cascades 1.2
import Network.GetterRequest 1.0
import bb.multimedia 1.0




TabbedPane {
    id: thisTab
    showTabsOnActionBar: true
    Menu.definition:  MenuDefinition {
        helpAction: HelpActionItem {
        
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                settings.open()
            }
        }
        actions: ActionItem {
            title: "About"
            onTriggered: {
                aboutus.open()
            }
        }

    }
   
    Tab {
        id: tabStart
        title: "Main"
        delegate: Delegate {
            id: delegateStart
            source: "Start.qml"
        }

        attachedObjects: [
            Settings {
                id: settings
                peekEnabled: false
            },
            About {
                id: aboutus
                peekEnabled: false
            }
        ]

        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateImmediately

    }
    Tab {
        id: tabCamSettings
        title: "Cam Settings"
        delegate: Delegate {
            id: delegateCamSettings
            source: "CamSettings.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateImmediately

    }

    Tab {
        id: tabLivePreview
        title: "Live Preview"
        delegate: Delegate {
            id: delegateLivePreview
            source: "LivePreview.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivatedWhileSelected
        
    }
    
    Tab {
        id: tabVideoViewer
        title: "File Viewer"
        delegate: Delegate {
            id: delegateVideoViewer
            source: "VideoViewer.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivatedWhileSelected
        //ActionBar.placement: ActionBarPlacement.InOverflow

    }

    
    
    onCreationCompleted: {
      Application.thumbnail.connect(onMinimized)
      }
    
    function onMinimized()
	{
        activeFrame.update(responseArea.text)
    }
	
	
}
