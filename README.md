# Arecont-Monochrome-Camera-Control
## What is this?
A PowerShell script to control the Arecont AV3130M dual-sensor color and monochrome security camera for the purposes of photography

## Why do this?
True monochrome photography. Certain cameras from Arecont (and presumably other manufacturers) include "Night Mode" sensors that are true monochrome Bayer-Filter-less sensors that are sensitive only to luminance and not chrominance.  Along with this, they are also full-spectrum, meaning they record visible light as well as infrared light.  This makes them extremely versatile, and in some cases actually more capable than dedicated monochrome cameras.  Generally speaking, cameras that have this capability are those which have two lenses side-by side [such as the AV3130M](https://sales.arecontvision.com/product/MegaVideo+Series/AV3130M)

## Prerequisites?
1) A compatible camera.  I personally own and have built and tested this script on an [Arecont AV3130M](https://sales.arecontvision.com/marketing/contents/AV3130_DS_HQ_ENG_052412.pdf), however, it should work reasonably well on any of the Arecont dual-lens day/night cameras. If you are using this script with a different Arecont camera, you may need to reference the [API Guide](https://http-api.arecontvision.com/) to get it working correctly with the different settings introduced with different models
2) The [Arecont AV IP Utility](https://sales.arecontvision.com/software.php).  This software will allow you to find an Arecont camera on your network (useful when buying used cameras that are setup for a different subnet than your own.
3) The [Arecont Firmware Loader](https://support.arecontvision.com/hc/en-us/articles/360034001173-How-to-use-Firmware-Loader) (linked at the bottom of the article).  Used if you have a camera that is either not on the latest firmware, or has an admin password set that you do not know
4) Powershell, with the ThreadJob module installed (Install-Module -Name ThreadJob -Scope CurrentUser)

## Setup
These setup instructions assume you are working with a used camera that is not setup for your network, and has an admin password installed that you do not know.  If you have your camera setup on your network and have **NO ADMIN PASSWORD** set on it (this script is unable to enter admin or user passwords, so you need to have anonymous access available, by not setting any passwords), you can skip to step **10**
1) Power on your camera, either via POE or direct connection to a power source and connect it to your network via ethernet.
2) Download the latest firmware for your camera, its easiest to just google "Arecont <model#> firmware" rather than trying to parse Areconts site.
3) On your computer, install and run the Arecont AV IP Utility.  This utility should auto detect your camera, even if it is configured for a different subnet, and show its IP.  You may need to allow the AV IP Utility in the Windows Firewall.

<img width="828" height="356" alt="20191011_127" src="https://github.com/user-attachments/assets/088c3f03-43e0-46c0-a520-c91d535e5a82" />

4) Connect your camera directly to your PC via ethernet.  Set your PC to have a custom ethernet IP address on the same subnet as the camera (for example, if your home network is a 192.168.x.x network and the camera is configured with an IP address of 10.0.0.20, set your PC to have ethernet address 10.0.0.21 or similar) so that the two can talk to each other.  You should be able to ping the camera after this step.
5) Run the Arecont Firmware Loader as administrator, you may need to allow the Firmware Loader in the Windows Firewall
   
   <img width="423" height="128" alt="admin" src="https://github.com/user-attachments/assets/9fa366fe-5e28-4765-8f45-078cc86738ee" />
   
6) Enter the IP of your camera and set the timeout to 1000ms

   <img width="703" height="288" alt="1001" src="https://github.com/user-attachments/assets/910bd442-87e4-43c8-8943-a0d1202ddf0d" />
   
7) Hit "Find Cameras". Your camera should appear
8) Hit "Upgrade Firmware".  It will take a minute, but it should hit 100% and say something along the lines of "Firmware Update Complete".  The Admin password should now be cleared out.
9) Go to the cameras IP in a web browser, and change the IP to something on your local subnet.
10) Browse to the cameras new IP.  You are now ready to connect to it with the Monocam script
11) Open the Monocam.PS1 file in a text editor
12) Edit the $baseUri variable to represent your cameras IP (ex. http://192.168.0.20)
13) Save the Monocam.PS1 file.
14) Start PowerShell as an Administrator
15) Run the Monocam.PS1 script

## Usage

The most useful way to use the Monocam script is to run the live view from the cameras web interface along with running the script at the same time.  This will allow you to have a live preview of the settings changes you make in the script, as you make them.  Arecont cameras have a hidden web page that is not exposed to the user, called livevideo.html.  To access it simply request that page in a web browser, http://<your-cameras-IP>/livevideo.html.  This will give you a nearly fullscreen live preview of what the camera sees.  I say "nearly" because my camera seems to crop some of the bottom off the live preview, so there is actually more in the image than shows up on the live preview.

<img width="975" height="509" alt="Screenshot" src="https://github.com/user-attachments/assets/62042c06-1e83-4fff-ba01-4c5bc8f505c8" />

Upon running the script, it will pull the current settings from the camera and display them on the main screen.

### Info
Press "i" to get more info on the camera, including some specs on the sensor, image size and other things not immediately available in the cameras web interface

### Rotating Images
If your image preview is upside-down, press "r" to rotate the image.  In the rotate menu, press 0 for 0 degree rotation, or 1 for 180 degree rotation

### Rebooting the camera
Occasionally, the camera will hang, or stop accepting settings changes.  Press 'x' to reboot the camera. You will be asked to confirm this before it reboots in order to avoid rebooting from accidental keypresses

### Factory resetting the camera
Occasionally, the camera will REALLY hang, or stop accepting settings, or sometimes you may get into a situation where you have changed enough that you just want to get back to the base settings.  Press "f" to "Factory Reset" the camera.  Factory reset is in quotes because what this really does is reset the imaging settings to default.  This will not reset the network or username/password settings.  Resetting those can only be done by re-flashing the firmware as described above.

### Taking images
Press the space bar to initiate the image taking process. The script calls the image function with a few variables set:

* res=full - There are two options here, _full_ and _half_, referring to resolution, however, for the purposes of photography, _full_ is the only useful one
* x0=0&y0=0&x1=2048&y1=1536 - This variable lays out the dimensions of the sensor.  The resulting image will be smaller than what is specified here, the camera appears to be doing some internal cropping that cannot (as of yet) be avoided.
* quality=21 - This specifies the level of compression.  This value runs inversely to the amount of compression.  A value of 1 will yield maximum compression and degradation of image quality.  21 results in the least compression and the best image quality.  Other model cameras may have quality variables that do not end at 21, depending on their firmware.
* doublescan=0 - This waits for the framebuffer to have a complete image in it before the JPEG is created from it.  This avoids partial or torn images.

### Low Light Exposure Mode
Press "s" to change the Low Light Exposure Mode.  Since we are using the monochrome (night) sensor, the camera considers everything we do to be in "low light", so the Low Light Mode settings take effect even in ambient light that the camera considers to be "day".  The script will request that you choose a mode from the available modes of:
* Highspeed - enables a fixed exposure time, selectable between 1 and 80ms. Low values will reduce motion blur but may result in noisier video. Ample illumination is required to improve quality under very short exposures due to the lack of captured light.
* Speed - enables short exposures ranging from 10-80ms. The exposure time will increase with low light conditions. The camera will select the shutter speed in this mode
* Balanced - enables medium exposures ranging from 20-80ms with low light conditions resulting in a higher exposure time.
* Quality - enables longer exposures ranging from 40-200ms. Motion blur may increase, but images will contain less noise under low light conditions.
* Moonlight - enables exposures of up to 500ms if necessary. This mode will result in more motion blur for fast moving objects.

### Day/Night mode
Press "n" to switch to Night mode.  The monochrome cameras seem to start up in day mode when cold booted. Day mode, notably, does not use a monochrome sensor, so is not the intended sensor for this script, however, the script should work fine with the color/day sensor.  Press "d" to switch to Day mode.  If the script shows that your day/night mode is in "auto" the camera will possibly flip from day to night mode automatically based on ambient light.  It is best to force one mode or the other for the purposes of photography.

### Auto Exposure
This setting is a bit confusing because the camera, as far as I can tell, never stops auto exposing the image, but you are able to change how it does it with the brightness setting, and the Low Light Exposure modes. Turn this off with "m" and on with "a"

### Brightness
Press "t" to change brightness.  This appears to be somewhat equivalent to a regular cameras exposure compensation setting, essentially forcing the camera to auto-expose to a higher or lower EV depending on the value set.  This function does not work if Auto Exposure is set to on

### Illumination (White Balance)
Press "w" to change the white balance between Automatic, Indoor, Outdoor and Mix
* Automatic is set by default and works for most situations
* Indoor will compensate for excessive “red” levels of illumination
* Outdoor will compensate for excessive “blue” levels of illumination
* Mix will compensate for excessive “red and blue” levels of illumination

### Custom Functions.
At the top of the Monocam.PS1 script, there are 3 pre-defined custom functions with all available settings listed in them. Change these functions to reflect any settings you use commonly.  You can then press 1, 2, or 3 to quickly change between groups of settings.
