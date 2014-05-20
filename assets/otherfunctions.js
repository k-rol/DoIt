/**
 * All functions from Start.qml
 */

//When onStatsReceived emitted
//
function StatsReceived(response, batterypercent, batteryBars, mode)
{
    Settings.setSettings("GetStats", 0);
    
    //sxTimer.start();
    buttonsContainer.enabled = true;
    powerButton.setChecked(true);
    
    responseArea.text = response;
    batteryLabel.text = batterypercent + "%";
    camMode.text = mode;
    
}

//When the onSignalNotGetStats is emitted, it then calls this function 
//
function NotGetStats()
{
    responseArea.text = "Off or Problem with connection...";
        
        var scount = Settings.getSettings("GetStats", 0);
        scount++;
        console.debug("SCOUNT: ",scount);
        Settings.setSettings("GetStats", scount);
        
        if (scount == 3) {
            deactAllButPower();
            resetNumbers();
            powerButton.setChecked(false);
            responseArea.text = "Disconnected!";
            seTimer.stop();
            getPasswordwithCounter();
            sxTimer.stop();
        }	
}

//When the onSignalNotGetPassword is emitted, it then calls this function 
//
function NoGetPassword()
{
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

//To make the stats labels to 0 / null / unknown
//
function resetNumbers()
{
    batteryLabel.text = "-%";
    camMode.text = "Unknown";
}

//GetPassword with Counter up to 3 times
//
function getPasswordwithCounter()
{
    inProcess.start();
    Settings.setSettings("GetPassword", 0);
    var pcount = Settings.getSettings("GetPassword", 0);
    console.debug("pcount:", pcount);
    
    console.debug("First Getpassword");
    
    //reset failed stat counter
    Settings.setSettings("GetStats", 0);
    
    getThis.GetPassword();
}


//to disable all buttons except the power one
//
function deactAllButPower()
{
    batteryImage.imageSource = "asset:///images/battery-full-icon0.png";
    buttonsContainer.enabled = false;
    responseArea.text = "Please restart DoIt GoPro to retry to connect...";
}


//To disable all buttons
//
function deactAllbuttons()
{
    rootContainer.enabled = false;
}

function sxStatsTimer()
{
	sxTimer.start();
	getThis.StatRequest(Settings.getSettings("password", ""),"sx");	
}