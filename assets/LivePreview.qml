import bb.cascades 1.2
import Network.GetterRequest 1.0
import bb.multimedia 1.0

Page {
    

Container {
    layout: DockLayout {
    }
    
    attachedObjects:[
        MediaPlayer {
            id: livePlayer
            sourceUrl: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"
            //sourceUrl: "http://10.5.5.9:8080/live/amba.m3u8"
            videoOutput: VideoOutput.PrimaryDisplay
            
            // The name of the window to create
            windowId: fwcLiveSurface.windowId
            
        }
    ]
    
    ForeignWindowControl {
        verticalAlignment: VerticalAlignment.Top
        id: fwcLiveSurface
        windowId: "myLiveSurface"
        visible: false
        updatedProperties: WindowProperty.Size |
        WindowProperty.Position |
        WindowProperty.Visible
        
        preferredWidth: 1280
        preferredHeight: 568
    }
    Container {
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            orientation: LayoutOrientation.BottomToTop
        }
        bottomMargin: 10.0
        topPadding: 300.0
        
        Container {
            
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            topMargin: 20.0

            Button {
                
                text: "Start Preview"
                onClicked: {
                    //livePlayer.setSourceUrl("http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")
                    fwcLiveSurface.visible = true
                    if (livePlayer.play() != MediaError.None) {
                        // Put your error handling code here
                    }
                }
                
            }
            
            Button {
                text: "Stop Preview"
                onClicked: {
                    fwcLiveSurface.visible = false
                    if (livePlayer.stop() != MediaError.None) {
                        // Put your error handing code here
                    }
                }
            }
            
        }
        
        Container {
            verticalAlignment: VerticalAlignment.Bottom
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            } 
            Button {
                
                text: "Snap Picture/Record"
                onClicked: {
                    getThis.GetRequest(doitsettings.getSettings("password"), "SH", "01");
                }
            }
            Button {
                text: "Stop Recording"
                onClicked: {
                    getThis.GetRequest(doitsettings.getSettings("password"), "SH", "00")
                }
            }
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

}

}