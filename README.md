# YAAP-Releases

## Realme gt master edition [RMX3360/61/63]

## Flashing Instructions

<b>To install YAAP on the Realme GT Master Edition (codename: lunaa), follow these steps:</b>

1. Download Recovery
- Download the [YAAP Recovery] file and extract it to a folder on your computer.

2. Flash the Recovery
- On Linux: Run the <b>flash.sh</b> script.
- On Windows: Run the <b>flash.bat</b> script.
This will flash the recovery and automatically boot your device into the YAAP recovery mode.

3. Wipe Data
In the recovery menu, select "Wipe data/factory reset" to clear existing data on the device.

4. Sideload CalyxOS
Use the following command in a terminal or command prompt to sideload the YAAP zip file:
``` adb sideload <path-to-filename.zip> ```

5. Wait for Completion
The sideload process will progress to 94% before finishing. This is normal—be patient until it completes.

6. Reboot
Once the sideload is done, select "Reboot system now" from the recovery menu. Congratulations! You’ve successfully flashed YAAP!

## Notes

- Always back up your data before starting the installation. 

## Support My Work

If you find my work on this project helpful, please consider supporting me through a donation:

- [GitHub Sponsor](https://github.com/sponsors/mvimal2607)  
- [PayPal](http://paypal.me/Vimal2607)  

Why Donations Matter for AOSP Projects? [read here](https://github.com/mvimal2607/.github?tab=readme-ov-file#why-donations-matter-for-aosp-projects).
