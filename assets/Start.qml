import bb.cascades 1.2
import Network.GetterRequest 1.0
import CustomerTimer 1.0 //QTIMER TIMER class
import QTimerLibrary 1.0 //QTIMER class

Page {
    id: startpage
    attachedObjects: [
    GetterRequest {
        id: getThis
        onCommandSent: {
            commandArea.text = commandSent;
        }
        onResponseReceived: {
            
            responseArea.text = info;
        
        }
        onStatsReceived: {
            responseArea.text = info
            batteryLabel.text = info2 + "%"
            camMode.text = info3
        }
        onPasswordReceived: {
            seTimer.start()
            responseArea.text = "Connecting..."
        }
        onTimerTimesOut: {
            retryDialog.open()
            seTimer.stop()
                //sxTimer.stop()
        }
        onReStartTimerSignal: {
            GetPassword();
        }
        
    },
    QTimer {
        id: sxTimer
        interval: 35000
        onTimeout: {
            getThis.StatRequest(doitsettings.getSettings("password"),"sx")
        
        }
    },
    RetryConnectionDialog {
        id: retryDialog
    }
]
     
    Container {
        layout: DockLayout {}
        //SE TIMER every 10 seconds
        Timer {
            id: seTimer
            interval: 5000
            
            onTimeout: {
                getThis.StatRequest(doitsettings.getSettings("password"),"se")
                console.debug("seTimer")
                if (responseArea.text = "Connecting...")
                {
                    responseArea.text = "Connected!"
                }
            }
            visible: false
        }
        //SX TIMER every 30 seconds
        ImageView {
            imageSource: "asset:///backgrounds/1.jpg"
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            scalingMethod: ScalingMethod.AspectFill
            opacity: 0.4
        }
        Container {

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                
                }
                horizontalAlignment: HorizontalAlignment.Center
                Label {
                    text: ""
                }
                Label {
                    // Localized text with the dynamic translation and locale updates support
                    text: qsTr("DoIt GoPro") + Retranslate.onLocaleOrLanguageChanged
                    textStyle.base: SystemDefaults.TextStyles.BigText
                    horizontalAlignment: HorizontalAlignment.Center
                    rightMargin: 100.0
                    leftMargin: 100.0
                
                }
                ImageView {
                    imageSource: "asset:///images/rec.png"
                    horizontalAlignment: HorizontalAlignment.Right
                    leftMargin: 0.0
                
                }
            
            }
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                
                }
                ToggleButton {
                    checked: false
                    onCheckedChanged: {
                        if (checked == true){
                            getThis.GetRequest(doitsettings.getSettings("password"), "PW", "01");
                        }
                        else {
                            getThis.GetRequest(doitsettings.getSettings("password"), "PW", "00");
                        }
                    }

                }
                /*                Button {
                    text: qsTr("On") + Retranslate.onLocaleOrLanguageChanged
                    
                    onClicked: {
                        
                        getThis.GetRequest(doitsettings.getSettings("password"), "PW", "01");
                    
                    }
                    preferredWidth: 10.0
                
                }
                Button {
                    text: qsTr("Off") + Retranslate.onLocaleOrLanguageChanged
                    onClicked: {
                        getThis.GetRequest(doitsettings.getSettings("password"), "PW", "00")                
                    }
                    preferredWidth: 10.0
                }*/

                Label {
                    id: labelConnection
                    text: "  Hero3 White"
                    translationY: 10.0
                    translationX: 20.0
                }
                Label {
                    id: batteryLabel
                    text: "00%"
                    leftMargin: 100.0
                    translationY: 10.0
                }
                ImageView {
                    imageSource: "asset:///images/battery-full-icon4.png"
                    scaleX: 0.75
                    scaleY: 0.75
                    translationY: -30.0
                    scalingMethod: ScalingMethod.AspectFit
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    
                    }
                
                }
            
            }
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                
                }
                horizontalAlignment: HorizontalAlignment.Center
                
                Container {
                    rightPadding: 20.0
                    Label {
                        text: "Video taken/left"
                    }
                    Label {
                        id: timeVideo
                        text: "88 / 11 minutes"
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                
                }
                
                Container {
                    leftPadding: 90.0
                    Label {
                        text: "Pix taken/left"
                    }
                    Label {
                        id: numPics
                        text: "8 / 466"
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                }
            }
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                
                }
                horizontalAlignment: HorizontalAlignment.Center
                
                topPadding: 50.0
                Container {
                    rightPadding: 20.0
                    Label {
                        text: "Photo Resolution"
                    }
                    Label {
                        id: videoMode
                        text: "5M"
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                
                }
                
                Container {
                    leftPadding: 90.0
                    Label {
                        text: "Camera Mode"
                        bottomMargin: 0.0
                    }
                    Label {
                        id: camMode
                        text: "Unknown"
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                }
            }
            Container {
                layout: StackLayout {
                
                }
                
                horizontalAlignment: HorizontalAlignment.Center
                topMargin: 0.0
                topPadding: 20.0
                bottomMargin: 0.0
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    
                    }
                    
                    Button {
                        text: "stats"
                        onClicked: {
                            getThis.StatRequest(doitsettings.getSettings("password"),"se")
                        }
                    }
                    Button {
                        text: "mocky"
                        onClicked: {
                            getThis.whatEveRequest("5320c1c979841eda163125a8")
                        }
                    }
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    
                    }
                    
                    topMargin: 0.0
                    topPadding: 20.0
                    Button {
                        text: "Snap Picture"
                    }
                    Button {
                        text: "Recording"
                    }
                }
            }
            
            Container {
                horizontalAlignment: HorizontalAlignment.Center

                TextArea {
                    id: responseArea
                    text: qsTr("Not Connected")
                    onTextChanged: {
                        activeFrame.update(responseArea.text)
                    }
                    textStyle.fontWeight: FontWeight.W400
                    textStyle.fontSize: FontSize.XSmall
                }    
            }
            
            TextArea {
                id: commandArea
                text: "Command here."
                visible: false
            }
        }
    }
    onCreationCompleted: {
        getThis.GetPassword()

    }
}
