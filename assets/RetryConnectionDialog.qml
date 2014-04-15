import bb.cascades 1.2
import CustomSignals 1.0

Dialog {
    id: retryDialog
    signal sendRestart()

    Container {
        preferredWidth: 768
        preferredHeight: 1280
        
        background: Color.create(0.0, 0.0, 0.0, 0.5)
        layout: DockLayout {
        }
        Container {
            maxHeight: 397
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            layout: DockLayout {
            }
            ImageView {
                imageSource: "asset:///images/dialogframe.png"
            }
            
            Container {
                topPadding: 10
                bottomPadding: 143
                leftPadding: 23
                rightPadding: 23
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
                Label {
                    text: "Can't Connect!"
                    textStyle.base: SystemDefaults.TextStyles.TitleText
                    textStyle.color: Color.White
                    horizontalAlignment: HorizontalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.7
                    }
                }
                Label {
                    text: "    Retry?"
                    textStyle.base: SystemDefaults.TextStyles.TitleText
                    textStyle.color: Color.White
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 3.5
                    }
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    Button {
                        text: "Retry"
                        
                        preferredWidth: 262.0
                        onClicked: {
                        	//cSignals.restartGetPasswordSlot()
                        	sendRestart()
                        	retryDialog.close()
                        }
                    }
                    Button {
                        text: "Cancel"
                        preferredWidth: 262.0
                        onClicked: {
                            retryDialog.close()
                        }
                                            
                    }    
                }
                
            }

        }
        
    }

}