import bb.cascades 1.2
import Network.GetterRequest 1.0
import bb.multimedia 1.0

Page {
    

    Container {
        layout: DockLayout {
        }
        
        attachedObjects:[
            MediaPlayer {
                id: vidPlayer
                sourceUrl: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"
                //sourceUrl: "http://10.5.5.9:8080/videos/DCIM/100GOPRO/GOPR0026.LRV"
                videoOutput: VideoOutput.PrimaryDisplay
                
                // The name of the window to create
                windowId: fwcVideoSurface.windowId
            
            
            }
        ]
        
        ForeignWindowControl {
            verticalAlignment: VerticalAlignment.Top
            id: fwcVideoSurface
            windowId: "myVideoSurface"
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
                        fwcVideoSurface.visible = true
                        //vidPlayer.setSourceUrl("http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")
                        if (vidPlayer.play() != MediaError.None) {
                            // Put your error handling code here
                        }
                    }
                
                }
                
                Button {
                    text: "Stop Preview"
                    onClicked: {
                        fwcVideoSurface.visible = false
                        if (vidPlayer.stop() != MediaError.None) {
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
