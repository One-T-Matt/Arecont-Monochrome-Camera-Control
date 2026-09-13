# Arecont-Monochrome-Camera-Control
## What is this?
A PowerShell script to control the Arecont AV3130M dual-sensor color and monochrome security camera for the purposes of photography

## Why do this?
Certain cameras from Arecont (and presumably other manufacturers) include "Night Mode" sensors that are true monochrome Bayer-Filter-less sensors that are sensitive only to luminance and not chrominance.  Along with this, they are also full-spectrum, meaning they record visible light as well as infrared light.  This makes them extremely versatile, and in some cases actually more capable than dedicated monochrome cameras.  Generally speaking, cameras that have this capability are those which have two lenses side-by side [such as the AV3130M](https://sales.arecontvision.com/product/MegaVideo+Series/AV3130M)

## Prerequisites?
1) A compatible camera.  I personally own and have built and tested this script on an [Arecont AV3130M](https://sales.arecontvision.com/marketing/contents/AV3130_DS_HQ_ENG_052412.pdf), however, it should work reasonably well on any of the Arecont dual-lens day/night cameras. If you are using this script with a different Arecont camera, you may need to reference the [API Guide](https://http-api.arecontvision.com/) to get it working correctly with the different settings introduced with different models
2) The [Arecont AV IP Utility](https://sales.arecontvision.com/software.php).  This software will allow you to find an Arecont camera on your network (useful when buying used cameras that are setup for a different subnet than your own.
3) The [Arecont Firmware Loader](https://support.arecontvision.com/hc/en-us/articles/360034001173-How-to-use-Firmware-Loader) (linked at the bottom of the article).  Used if you have a camera that is either not on the latest firmware, or has an admin password set that you do not know
4) Powershell, with the ThreadJob module installed (Install-Module -Name ThreadJob -Scope CurrentUser)

## Setup
These setup instructions assume you are working with a used camera that is not setup for your network, and has an admin password installed that you do not know.  If you have your camera setup on your network and have NO ADMIN PASSWORD set on it, you can skip to step **10**
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
