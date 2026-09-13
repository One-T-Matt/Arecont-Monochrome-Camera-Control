#========================================================
#USER DETAILS, EDIT WITH YOUR IP OR FQDN
$baseUri = 'http://x.x.x.x'
#========================================================

function CustomFn1
{

#========================================================
#UNCOMMENT ANY LINES THAT YOU WOULD LIKE TO HAVE SET AS A TEMPLATE
#LEAVE THE COMMENTS TO THE RIGHT COMMENTED OUT
#Write-Host "Executing: Custom Function Moonlight"                                                           #RENAME WITH YOUR OWN DESCRIPTION
#(Invoke-WebRequest -Uri "$baseUri/set?daynight=night" -UseBasicParsing).content                             #USE DAYNIGHT=DAY/NIGHT
#(Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content                                 #USE AUTOEXP=ON/OFF
#(Invoke-WebRequest -Uri "$baseUri/set?lowlight=moonlight" -UseBasicParsing).content                         #USE LOWLIGHT=HIGHSPEED/SPEED/BALANCE/QUALITY/MOONLIGHT, AUTOEXP SHOULD BE ON
#(Invoke-WebRequest -Uri "$baseUri/set?day_binning=off" -UseBasicParsing).content                            #USE DAY_BINNING=ON/OFF
#(Invoke-WebRequest -Uri "$baseUri/set?night_binning=on" -UseBasicParsing).content                           #USE NIGHT_BINNING=ON/OFF
#(Invoke-WebRequest -Uri "$baseUri/set?rotate=0" -UseBasicParsing).content                                   #USE ROTATE=0/180
#(Invoke-WebRequest -Uri "$baseUri/set?brightness=1" -UseBasicParsing).content                               #USE BRIGHTNESS=1 THROUGH 50
#(Invoke-WebRequest -Uri "$baseUri/set?spacialfilter=0" -UseBasicParsing).content                            #USE SPACIALFILTER=0 TO 100
#(Invoke-WebRequest -Uri "$baseUri/set?illum=outdoor" -UseBasicParsing).content                              #USE ILLUM=AUTO/INDOOR/OUTDOOR/MIX (THIS IS EQUIVALENT TO WHITE BALANCE)
pause
Show-Menu
} #END CUSTOMFN1 FUNCTION

function CustomFn2
{

#========================================================
#UNCOMMENT ANY LINES THAT YOU WOULD LIKE TO HAVE SET AS A TEMPLATE
#LEAVE THE COMMENTS TO THE RIGHT COMMENTED OUT
#Write-Host "Executing: Custom Function Night"                                                              #RENAME WITH YOUR OWN DESCRIPTION
#(Invoke-WebRequest -Uri "$baseUri/set?daynight=night" -UseBasicParsing).content                            #USE DAYNIGHT=DAY/NIGHT
#(Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content                                #USE AUTOEXP=ON/OFF
#(Invoke-WebRequest -Uri "$baseUri/set?lowlight=quality" -UseBasicParsing).content                          #USE LOWLIGHT=HIGHSPEED/SPEED/BALANCE/QUALITY/MOONLIGHT, AUTOEXP SHOULD BE ON
#(Invoke-WebRequest -Uri "$baseUri/set?day_binning=off" -UseBasicParsing).content                           #USE DAY_BINNING=ON/OFF
#(Invoke-WebRequest -Uri "$baseUri/set?night_binning=on" -UseBasicParsing).content                          #USE NIGHT_BINNING=ON/OFF
#(Invoke-WebRequest -Uri "$baseUri/set?rotate=0" -UseBasicParsing).content                                  #USE ROTATE=0/180
#(Invoke-WebRequest -Uri "$baseUri/set?brightness=1" -UseBasicParsing).content                              #USE BRIGHTNESS=1 THROUGH 50
#(Invoke-WebRequest -Uri "$baseUri/set?spacialfilter=0" -UseBasicParsing).content                           #USE SPACIALFILTER=0 TO 100
#(Invoke-WebRequest -Uri "$baseUri/set?illum=auto" -UseBasicParsing).content                                #USE ILLUM=AUTO/INDOOR/OUTDOOR/MIX (THIS IS EQUIVALENT TO WHITE BALANCE)
pause
Show-Menu
} #END CUSTOMFN2 FUNCTION

function CustomFn3
{

#========================================================
#UNCOMMENT ANY LINES THAT YOU WOULD LIKE TO HAVE SET AS A TEMPLATE
#LEAVE THE COMMENTS TO THE RIGHT COMMENTED OUT
Write-Host "Executing: Custom Function 3"                                                                   #RENAME WITH YOUR OWN DESCRIPTION
# (Invoke-WebRequest -Uri "$baseUri/set?daynight=day" -UseBasicParsing.content                              #USE DAYNIGHT=DAY/NIGHT
# (Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content                               #USE AUTOEXP=ON/OFF
# (Invoke-WebRequest -Uri "$baseUri/set?lowlight=highspeed" -UseBasicParsing).content                       #USE LOWLIGHT=HIGHSPEED/SPEED/BALANCE/QUALITY/MOONLIGHT, AUTOEXP SHOULD BE ON
# (Invoke-WebRequest -Uri "$baseUri/set?day_binning=off" -UseBasicParsing).content                          #USE DAY_BINNING=ON/OFF
# (Invoke-WebRequest -Uri "$baseUri/set?night_binning=on" -UseBasicParsing).content                         #USE NIGHT_BINNING=ON/OFF
# (Invoke-WebRequest -Uri "$baseUri/set?rotate=0" -UseBasicParsing).content                                 #USE ROTATE=0/180
# (Invoke-WebRequest -Uri "$baseUri/set?brightness=1" -UseBasicParsing).content                             #USE BRIGHTNESS=1 THROUGH 50
# (Invoke-WebRequest -Uri "$baseUri/set?spacialfilter=0" -UseBasicParsing).content                          #USE SPACIALFILTER=0 TO 100
# (Invoke-WebRequest -Uri "$baseUri/set?illum=auto" -UseBasicParsing).content                               #USE ILLUM=AUTO/INDOOR/OUTDOOR/MIX (THIS IS EQUIVALENT TO WHITE BALANCE)
pause
Show-Menu
} #END CUSTOMFN3 FUNCTION

function Get-Images
{
cls

$files = @(
    @{
        Uri = "$baseUri/image?res=full&x0=0&y0=0&x1=2048&y1=1536&quality=21&doublescan=0"
        OutFile = "Mono-$(Get-Date -Format yyyy-MM-dd_HH-mm-ss).jpg"
    }  
)

$jobs = @()

foreach ($file in $files) {
    $jobs += Start-ThreadJob -Name $file.OutFile -ScriptBlock {
        $params = $Using:file
        (Invoke-WebRequest @params).content
    }
}

Write-Host "Downloads started..."
Wait-Job -Job $jobs

foreach ($job in $jobs) {
    Receive-Job -Job $job
} pause
}
#END GET-IMAGES FUNCTION

function Set-Day
{
    Invoke-WebRequest -Uri "$baseUri/set?daynight=day" -UseBasicParsing
}#END SET-DAY FUNCTION

function Set-Night
{
    Invoke-WebRequest -Uri "$baseUri/set?daynight=night" -UseBasicParsing
}#END SET-NIGHT FUNCTION

function Get-CameraInfo
{
    cls
    [string]$Daynight =  Invoke-WebRequest -Uri "$baseUri/get?daynight" -UseBasicParsing
    Write-Host "Day/Night Mode (IR CUT Filter On/Off): $Daynight"
    [string]$brightnessval = Invoke-WebRequest -Uri "$baseUri/get?brightness" -UseBasicParsing
    Write-Host "$brightnessval"
    [string]$illumval = Invoke-WebRequest -Uri "$baseUri/get?illum" -UseBasicParsing
    Write-Host "White Bal: $illumval"
    [string]$lowlightmode = Invoke-WebRequest -Uri "$baseUri/get?lowlight" -UseBasicParsing
    Write-Host "Low Light Mode: $lowlightmode"
    [string]$daybinningmode = Invoke-WebRequest -Uri "$baseUri/get?day_binning" -UseBasicParsing
    Write-Host "Day Binning Mode: $daybinningmode"
    [string]$nightbinningmode = Invoke-WebRequest -Uri "$baseUri/get?day_binning" -UseBasicParsing
    Write-Host "Night Binning Mode: $nightbinningmode"
    [string]$sharpnessval = Invoke-WebRequest -Uri "$baseUri/get?sharpness" -UseBasicParsing
    Write-Host "$sharpnessval"
    [string]$saturationval = Invoke-WebRequest -Uri "$baseUri/get?saturation" -UseBasicParsing
    Write-Host "$saturationval"
    [string]$autoexpval = Invoke-WebRequest -Uri "$baseUri/get?autoexp" -UseBasicParsing
    Write-Host "$autoexpval"
    [string]$sensorwidthval = Invoke-WebRequest -Uri "$baseUri/get?sensorwidth" -UseBasicParsing
    Write-Host "$sensorwidthval"
    [string]$sensorheightval = Invoke-WebRequest -Uri "$baseUri/get?sensorheight" -UseBasicParsing
    Write-Host "$sensorheightval"
    [string]$imgwidthval = Invoke-WebRequest -Uri "$baseUri/get?imgwidth" -UseBasicParsing
    Write-Host "$imgwidthval"
    [string]$imgheightval = Invoke-WebRequest -Uri "$baseUri/get?imgheight" -UseBasicParsing
    Write-Host "$imgheightval"
    [string]$imgqualityval = Invoke-WebRequest -Uri "$baseUri/get?imgquality" -UseBasicParsing
    Write-Host "$imgqualityval"
    [string]$imgresval = Invoke-WebRequest -Uri "$baseUri/get?imgres" -UseBasicParsing
    Write-Host "$imgresval"
    [string]$macval = Invoke-WebRequest -Uri "$baseUri/get?mac" -UseBasicParsing
    Write-Host "$macval"
    [string]$makeval = Invoke-WebRequest -Uri "$baseUri/get?make" -UseBasicParsing
    Write-Host "$makeval"
    [string]$modelval = Invoke-WebRequest -Uri "$baseUri/get?model" -UseBasicParsing
    Write-Host "$modelval"
    [string]$fwversionval = Invoke-WebRequest -Uri "$baseUri/get?fwversion" -UseBasicParsing
    Write-Host "$fwversionval"
    [string]$procversionval = Invoke-WebRequest -Uri "$baseUri/get?procversion" -UseBasicParsing
    Write-Host "$procversionval"
    [string]$netversionval = Invoke-WebRequest -Uri "$baseUri/get?netversion" -UseBasicParsing
    Write-Host "$netversionval"
    [string]$revisionval = Invoke-WebRequest -Uri "$baseUri/get?revision" -UseBasicParsing
    Write-Host "$revisionval"

    Write-Host
    pause
}#END GET-CAMERAINFO FUNCTION

function Reboot-Camera
{
    cls
    Write-Host "ARE YOU SURE YOU WANT TO REBOOT THE CAMERA? (y/n): " -NoNewLine
    $key = $Host.UI.RawUI.ReadKey()
            switch ($key.Character)
            {

           "y"
                {
                Write-Host
                Write-Host "Rebooting Camera, please wait (Seeing an error about timeouts or connection closed is normal here)"
                Invoke-WebRequest -Uri "$baseUri/set?params=reboot" -UseBasicParsing -TimeoutSec 60
                Write-Host "Camera Rebooted"
                }

            "n" 
                {
                 return
                }

            default
                {
                return
                }
            }
   
    pause
}

function FactoryReset
{
    cls
    Write-Host "ARE YOU ABSOLUTELY SURE YOU WANT TO FACTORY RESET THE CAMERA? This will not reset networking info, or logins (y/n): " -NoNewLine
    $key = $Host.UI.RawUI.ReadKey()
            switch ($key.Character)
            {

           "y"
                {
                Write-Host
                Write-Host "Factory Resetting Camera (Seeing an error about timeouts or connection closed is normal here)"
                Invoke-WebRequest -Uri "$baseUri/set?params=factory" -UseBasicParsing -TimeoutSec 60
                Write-Host "Camera Factory Reset Complete"
                }

            "n" 
                {
                 return
                }

            default
                {
                return
                }
            }
   
    pause
}

function Set-AutoexpON
{
    cls
    (Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content #For some reason this specific query also returns headers, using .content strips them out
    Write-Host "AutoExposure On" -Foregroundcolor green
    Write-Host
    pause
} #END SET-AUTOEXPON FUNCTION

function Set-AutoexpOFF
{
    cls
    (Invoke-WebRequest -Uri "$baseUri/set?autoexp=off" -UseBasicParsing).content #For some reason this specific query also returns headers, using .content strips them out
    Write-Host "AutoExposure Off" -Foregroundcolor green
    Write-Host
    pause
} #END SET-AUTOEXPOFF FUNCTION

#BEGIN SET-NIGHTEXPOSUREMODE FUNCTION
function Set-NightExposureMode
{
    cls
    Write-Host "Exposure Mode? (G: GET HELP | H: Highspeed | S: Speed | B: Balance | Q: Quality"
    Write-Host "                M: Moonlight | X: Exit without changing settings): " -NoNewLine
    $key = $Host.UI.RawUI.ReadKey()
            switch ($key.Character)
            {

           "g"
                {
                cls
                
Write-Host "NOTE: THESE MODES MUST BE USED WITH AUTOEXPOSURE SET TO ON" -Foregroundcolor red
Write-Host @"
The shutter speed is automatically controlled by the camera. Motion blur may occur when the camera
operates at slow shutter speeds (long exposure times, such as the scene being relatively dark).
Arecont Vision cameras provide a number of options that allow the user to control auto-exposure
behavior when illumination is low.

The user can set the preferred exposure time that the camera will attempt to maintain as long as
illumination level allows. This setting essentially allows the user to choose the tradeoff between
gains and exposure time at reduced light levels. There are 3 basic settings: SPPED, BALANCE, and
QUALITY. 

The Speed setting will result in higher image noise but will attempt to maintain 10ms exposure time
for as long as possible, reducing motion artifacts. The Quality setting will maintain 40 ms exposure
time, resulting in low-noise image with some motion blur in low light. The Balanced setting falls
between Quality and Speed. 

There are also two special modes, High Speed and MoonLight, which can be used for very fast
moving targets and very low illumination, respectively. High Speed mode allows the user to specify a
fixed exposure time in terms of milliseconds (from 1 to 80). While this will allow crisp video of 
fast moving vehicles, the side effect of this setting is that low-light performance of the camera 
will be significantly worse (up to 800 times) than in default mode. Therefore, High Speed should
only be used for well lit scenes.

The other special mode, MoonLight implements long exposure times of up to 0.5 seconds in
combination with proprietary noise cancellation technology. This mode allows viewing under
extremely low illumination conditions. It is important to note, that MoonLight is NOT digital frame
integration and will offer significantly better image quality than cameras that employ digital frame
integration. However, the motion blur will still be significant.

Setting the Low Light Mode to Speed is the first thing to try to eliminate motion blur.
"@
                
                pause
                Set-NightExposureMode
                }

            "h" 
                {
                cls
                Write-Host "Turning AutoExposure On"    
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content #For some reason this specific query also returns headers, using .content strips them out
                Write-Host "AutoExposure On" -Foregroundcolor green
                Write-Host
                Write-Host
                Write-Host "Setting all channels to High Speed"
                Write-Host
                Write-Host "Current High Speed shutter value is: " -NoNewLine
                (Invoke-WebRequest -Uri "$baseUri/get?shortexposures" -UseBasicParsing).content
                Write-Host
                $userhighspeedval = Read-Host "Please enter a high speed shutter value from 1 to 80ms, or Q to exit: "
    
                if ($userhighspeedval -in 1..80) 
                { 
                (Invoke-WebRequest -Uri "$baseUri/set?lowlight=highspeed" -UseBasicParsing).content
                (Invoke-WebRequest -Uri "$baseUri/set?shortexposures=$userhighspeedval" -UseBasicParsing).content
                Write-Host "High Speed: $userhighspeedval ms" -Foregroundcolor green
                Write-Host
                }
                }

            "s" 
                {
                cls
                Write-Host "Turning AutoExposure On"    
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content #For some reason this specific query also returns headers, using .content strips them out
                Write-Host "AutoExposure On" -Foregroundcolor green
                Write-Host
                Write-Host
                Write-Host "Setting all channels to Speed"
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?lowlight=speed" -UseBasicParsing).content
                Write-Host "Speed" -Foregroundcolor green
                Write-Host
                }


            "b" 
                {
                cls
                Write-Host "Turning AutoExposure On"    
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content #For some reason this specific query also returns headers, using .content strips them out
                Write-Host "AutoExposure On" -Foregroundcolor green
                Write-Host
                Write-Host
                Write-Host "Setting all channels to Balance"
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?lowlight=balance" -UseBasicParsing).content
                Write-Host "Balance" -Foregroundcolor green
                Write-Host
                }

            "q" 
                {
                cls
                Write-Host "Turning AutoExposure On"    
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content #For some reason this specific query also returns headers, using .content strips them out
                Write-Host "AutoExposure On" -Foregroundcolor green
                Write-Host
                Write-Host
                Write-Host "Setting all channels to Quality"
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?lowlight=quality" -UseBasicParsing).content
                Write-Host "Quality" -Foregroundcolor green
                Write-Host
                }

            "m" 
                {
                cls
                Write-Host "Turning AutoExposure On"    
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?autoexp=on" -UseBasicParsing).content #For some reason this specific query also returns headers, using .content strips them out
                Write-Host "AutoExposure On" -Foregroundcolor green
                Write-Host
                Write-Host
                Write-Host "Setting all channels to Moonlight"
                Write-Host
                (Invoke-WebRequest -Uri "$baseUri/set?lowlight=moonlight" -UseBasicParsing).content
                Write-Host "Moonlight" -Foregroundcolor green
                Write-Host
                }                

            "x"
                {
                Write-Host
                return
                } 
            }
   
    pause
} #END SET-NIGHTEXPOSUREMODE FUNCTION

 function Set-Rotation
 {
    cls
    Write-Host "Current rotation: " -Nonewline
    Write-Host (Invoke-WebRequest -Uri "$baseUri/get?rotate" -UseBasicParsing).content
    Write-Host
    Write-Host "How would you like to set the sensor rotation? 0=0 Degrees, 1=180 Degrees (0/1) or Q to return: " -NoNewLine
    $key = $Host.UI.RawUI.ReadKey()
            switch ($key.Character)
            {

           "0"
                {
                  Write-Host
                  Write-Host "Rotating sensor images to 0 degrees"  
                  (Invoke-WebRequest -Uri "$baseUri/set?rotate=0" -UseBasicParsing).content
                  Write-Host
                }

            "1" 
                {
                Write-Host
                Write-Host "Rotating sensor images to 180 degrees"  
                (Invoke-WebRequest -Uri "$baseUri/set?rotate=180" -UseBasicParsing).content
                Write-Host
                }
            "q"
                {
                return
                }    
            }
   
    pause
} #END SET-ROTATION FUNCTION

function Set-Brightness
{
    cls
    $userbrightnessval = Read-Host "Please enter a brightness value from -50 to 50, or Q to exit: "
    
    if ($userbrightnessval -in -50..50) 
    { 
        (Invoke-WebRequest -Uri "$baseUri/set?brightness=$userbrightnessval" -UseBasicParsing).content

        Pause  
    }

    elseif ($userbrightnessval -eq "q")
    {
        return
    }

    else
    {
    Write-Host "Invalid Value"
    pause
    Set-Brightness
    }
} #END SET-BRIGHTNESS FUNCTION

function Set-Illum
{
    [string]$illumval = Invoke-WebRequest -Uri "$baseUri/get?illum" -UseBasicParsing
    Write-Host "Current Illumination (White Bal) Value: " -NoNewLine
    Write-Host "$illumval"
    Write-Host
    Write-Host "Enter new Illum Value (a)uto/(i)ndoor/(o)utdoor/(m)ix, or Q to quit: " -NoNewline
    $key = $Host.UI.RawUI.ReadKey()
            switch ($key.Character)
            {

            "a"
                {
                    Write-Host
                    Write-Host "Illum Value: " -Nonewline
                    (Invoke-WebRequest -Uri "$baseUri/set?illum=auto" -UseBasicParsing).content
                    pause
                }

            "i" 
                {
                    Write-Host
                    Write-Host "Illum Value: " -Nonewline
                    (Invoke-WebRequest -Uri "$baseUri/set?illum=indoor" -UseBasicParsing).content
                    pause
                }

            "o"
                {
                    Write-Host
                    Write-Host "Illum Value: " -Nonewline
                    (Invoke-WebRequest -Uri "$baseUri/set?illum=outdoor" -UseBasicParsing).content
                    pause
                }
            "m"
                {
                    Write-Host
                    Write-Host "Illum Value: " -Nonewline
                    (Invoke-WebRequest -Uri "$baseUri/set?illum=mix" -UseBasicParsing).content

                    pause
                }

            "q"
                {
                Write-Host
                return
                }

            default
                {
                Write-Host "Invalid Value"
                pause    
                Set-Illum
                }    
            }
} #END SET-ILLUM FUNCTION


#START SHOW-MENU FUNCTION
function Show-Menu
 {
            param (
            [string]$Title = "Arecont AV3130M Monochrome Camera Control"
            )
            cls
            Write-Host "================ $Title ================" -Foregroundcolor green
            Write-Host "Current Server: " -Foregroundcolor cyan -NoNewLine
            Write-Host "$baseUri" -NoNewline
            Write-Host ("{0,40}" -f "Last Key Pressed: $lastkey") -Foregroundcolor red #Right justified, 40 char width

            [string]$Daynight =  Invoke-WebRequest -Uri "$baseUri/get?daynight" -UseBasicParsing
            Write-Host "$Daynight" -Foregroundcolor cyan -NoNewLine

            [string]$brightnessval = Invoke-WebRequest -Uri "$baseUri/get?brightness" -UseBasicParsing
            Write-Host ("{0,20}" -f "$brightnessval") -NoNewLine -Foregroundcolor cyan

            [string]$autoexpval = Invoke-WebRequest -Uri "$baseUri/get?autoexp" -UseBasicParsing
            Write-Host ("{0,40}" -f "$autoexpval") -Foregroundcolor cyan

            [string]$illumval = Invoke-WebRequest -Uri "$baseUri/get?illum" -UseBasicParsing
            Write-Host ("{0,0}" -f "White Bal: ") -Foregroundcolor cyan -NoNewLine
            Write-Host "$illumval" -NoNewLine

            [string]$lowlightmode = Invoke-WebRequest -Uri "$baseUri/get?lowlight" -UseBasicParsing
            Write-Host ("{0,17}" -f "Low Light Mode: ")  -Foregroundcolor cyan -NoNewLine
            Write-Host "$lowlightmode" -NoNewLine

            [string]$HSShutter = Invoke-WebRequest -Uri "$baseUri/get?shortexposures" -UseBasicParsing
            Write-Host ("{0,22}" -f "High Speed Shutter: ") -Foregroundcolor cyan -NoNewLine
            Write-Host "$HSShutter ms"
            Write-Host
            Write-Host
            Write-Host
            Write-Host
            Write-Host
            Write-Host "HARDWARE CONTROL================================================================================" -ForegroundColor green
            Write-Host "R: Rotate Images"
            Write-Host "I: Get Camera Info | X: Reboot Camera | F: Factory Reset"
            Write-Host "IMAGING CONTROL=================================================================================" -ForegroundColor green
            Write-Host "Spacebar: Capture Images | S: Set Low Light Exposure Mode | D: Day Mode | N: Night Mode"
            Write-Host "A: AutoExposure ON | M: AutoExposure OFF"
            Write-Host "T: Brightness (1-50) | W: Illum (White Bal)"
            Write-Host "CUSTOM FUNCTIONS================================================================================" -ForegroundColor green
            Write-Host "1: Custom Fn1 | 2: Custom Fn2 | 3: Custom Fn3"
            Write-Host "================================================================================================" -Foregroundcolor green
            Write-Host "Q: Quit"
 } #END FUNCTION SHOW-MENU

#BEGIN MAIN LOOP
 do
 {
            Show-Menu
            #$input = Read-Host "Please make a selection"
            $key = $Host.UI.RawUI.ReadKey()
            switch ($key.VirtualKeyCode) #VirtualKeyCode allows use of special, non-alphanumeric keys.  KeyCharacter, as used in other switch statements, is limited to A-Z, 1-0
            {

           "68" #68=D
                {
                Set-Day
                $lastkey = "D"
                }
           
            "78" #78=N
                {
                Set-Night
                $lastkey = "N"
                }
           
            "82" #82=R
                {
                Set-Rotation
                $lastkey = "R"
                } 
            
             "32" #32=Spacebar
                {
                Get-Images
                $lastkey = "Space"
                }  
           
            "73" #73=I
                {
                Get-CameraInfo
                $lastkey = "I"
                }  
             
             "65" #65=A
                {
                Set-AutoexpON
                $lastkey = "A"
                }
            
            "77" #77=M
                {
                Set-AutoexpOFF
                $lastkey = "M"
                }        
            
             "88" #88=X
                {
                Reboot-Camera
                $lastkey = "X"
                }
             
             "83" #83=S
                {
                Set-NightExposureMode
                $lastkey = "S"
                } 

            "70" #70=F
                {
                FactoryReset
                $lastkey = "F"
                }

            "84" #84 = F
                {
                Set-Brightness
                $lastkey = "T"
                }

            "87" #87 = L
                {
                Set-Illum
                $lastkey = "W"
                }

            "49" #49 = 1
                {
                CustomFn1
                $lastkey = "1"
                }  

            "50" #50 = 2
                {
                CustomFn2
                $lastkey = "2"
                }

            "51" #51 = 3
                {
                CustomFn3
                $lastkey = "3"
                }            


            "81" 
                { #81=Q
                return
                }
            }
            #pause
 }
 until ($key -eq 'q')
 #END MAIN LOOP