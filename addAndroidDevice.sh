#!/bin/sh

# Check idVendor
lsusb

# Request of idVendor
echo "Enter idVendor:"
read idVendor

# Create string
rule='SUBSYSTEM=="usb", ATTR{idVendor}=="'"$idVendor"'", MODE="0666", GROUP="plugdev"'

# Add rule
if grep -qF "$rule" /etc/udev/rules.d/51-android.rules; then
    echo "Rule is already exists"
else
    echo "Add rule to /etc/udev/rules.d/51-android.rules..."
    echo "$rule" | sudo tee -a /etc/udev/rules.d/51-android.rules > /dev/null

    # Reload rules
    echo "Update rules udev..."
    sudo udevadm control --reload-rules
    sudo udevadm trigger
fi
adb kill-server

echo "Done."
