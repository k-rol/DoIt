import bb.cascades 1.2
import Network.GetterRequest 1.0
import CustomerTimer 1.0 //QTIMER TIMER class
import QTimerLibrary 1.0 //QTIMER class
import bb.system 1.2
import "asset:///otherfunctions.js" as CamFunctions 

Page {
    id: startpage
    attachedObjects: [
        Timer {
            id: sxTimer
            interval: 5500
            onTimeout: {
                getThis.StatRequest(Settings.getSettings("password", ""),"sx")
            
            }
        },
        //SE TIMER every 10 seconds
        Timer {
            id: seTimer
            interval: 5000
            
            onTimeout: {
                getThis.StatRequest(Settings.getSettings("password", ""),"se")
                console.debug("seTimer")
                if (responseArea.text = "Connecting...")
                {
                    responseArea.text = "Connected!"
                }
            }
            visible: false
        },
        SystemToast {
            id: cancelledAlert
            body: "You will need to restart the app if you want to connect it later on"
          },
        GetterRequest {
            id: getThis
            onCommandSent: {
                commandArea.text = commandSent;
            }
            
            onResponseReceived: {
                responseArea.text = info;
            }

            onStatsReceived: {
                //reset NoStat counter
                CamFunctions.StatsReceived(response, batterypercent, mode)
            }
            
            onStatSXReceived: {
                CamFunctions.StatSXReceived(batteryBars)
                
            }
            
            onPasswordReceived: {
                inProcess.stop()
                seTimer.start()
                sxTimer.start()
                responseArea.text = "Connecting..."
            }
            
            onTimerTimesOut: {
                seTimer.stop()
                sxTimer.stop()
            }
            
            onSignalNotGetPassword: {
                //CamFunctions.NotGetPassword()
                var pcount = Settings.getSettings("GetPassword", 0);
                //console.debug("pcount:", pcount)
                pcount++;
                Settings.setSettings("GetPassword", pcount);
                
                if (pcount != 3) {
                    //console.debug("pcount:", pcount)
                    //console.debug("2nd or 3rd Getpassword")
                    GetPassword();
                    responseArea.text = "Attempt to get password...";
                }
                if (pcount == 3) {
                    //console.debug("Start retryDialog and pcount=",pcount)
                    inProcess.stop();
                    retryDialog.open();
                    responseArea.text = "Cannot connect to GoPro";
                }	

            }
            
            onSignalNotGetStats: {
                CamFunctions.NotGetStats()
            }
        
        },
        RetryConnectionDialog {
            id: retryDialog
            onSendRestart: {
                CamFunctions.getPasswordwithCounter()
            }
            onCancelRestart: {
                inProcess.stop()
                //CamFunctions.deactAllButPower()
                CamFunctions.deactAllbuttons()
                cancelledAlert.show()
            }
        }
    ]
    //Root Container
    Container {
        id: rootContainer
        layout: DockLayout {}
        
        ImageView {
            imageSource: "asset:///backgrounds/1.jpg"
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            scalingMethod: ScalingMethod.AspectFill
            opacity: 0.4
        }

        //Container with anything other than background
        Container {
            //Container with very top layer
            
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
            
            }//End of very top layer Container
            
            //Container with ToggleButton+CamTitle+Battery%
            Container {
                id: secondlayerContainer
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                
                }
                ToggleButton {
                    id: powerButton
                    checked: false
                    onCheckedChanged: {
                        if (checked == true){
                            getThis.GetRequest(Settings.getSettings("password", ""), "PW", "01");
                        }
                        else {
                            getThis.GetRequest(Settings.getSettings("password", ""), "PW", "00");
                        }
                    }
                
                }
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
                    id: batteryImage
                    imageSource: "asset:///images/battery-full-icon3.png"
                    scaleX: 0.75
                    scaleY: 0.75
                    translationY: -30.0
                    scalingMethod: ScalingMethod.AspectFit
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    
                    }
                
                }
            
            }//End of secondlayerContainer
            
            //Container with Video Taken / Pix Taken
            Container {
                id: firstrowInfoContainer
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
            }//End firstrowInfoContainer
            
            //Container with PhotoRes/CamMode
            Container {
                id: secrowInfoContainer
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
            }//secrowInfoContainer
            //Container for ActivityIndicator+4buttons
            Container {
                layout: DockLayout {
                
                }
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                
                
                //Container with the 4 buttons
                Container {
                    id: buttonsContainer
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
                                getThis.StatRequest(Settings.getSettings("password", ""),"se")
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
                }//End of 4 buttons Container
                ActivityIndicator {
                    id: inProcess
                    preferredWidth: 130
                    preferredHeight: 130
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
            }//End of Container for ActivityIndicator+4buttons
            
            //Container with Status textarea
            Container {
                id: textareaContainer
                horizontalAlignment: HorizontalAlignment.Center
                
                TextArea {
                    id: responseArea
                    text: qsTr("Not Connected")
                    onTextChanged: {
                        activeFrame.update(responseArea.text)
                    }
                    textStyle.fontWeight: FontWeight.W400
                    textStyle.fontSize: FontSize.XSmall
                    enabled: false
                }    
            }//End of textareaContainer
            
            TextArea {
                id: commandArea
                text: "Command here."
                visible: false
            }
        }//End of Container with anything other than background
    }//End Root Container
    
    onCreationCompleted: {
        //getThis.GetPassword()
        CamFunctions.getPasswordwithCounter()
    }
    
}
