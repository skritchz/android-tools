#!/bin/bash
echo "----------------------------------------------------"
echo "     DooMLoRD's kernel.sin and FTF creator (v1.0)	  "
echo "----------------------------------------------------"
echo "               FOR XPERIA X10 ONLY                  "
echo "----------------------------------------------------"
echo "  Credits:                                          "
echo "     the_laser - sin packer tools                   "
echo "     Androxyde - FTF packer tools                   "
echo "     DooMLoRD  - making this easy for all ;)        "
echo "----------------------------------------------------"
echo "  before you begin make sure that:                  "
echo "     kernel's zImage is called "image"              "
echo "     ramdisk.cpio.gz is called "ramdisk"            "
echo "----------------------------------------------------"
cp $1/arch/arm/boot/zImage .
./bin2elf 2 0x20008000 zImage 0x20008000 0x0 ramdisk 0x24000000 0x80000000
./bin2sin result.elf 03000000220000007502000062000000
rm result.elf
mv result.elf.sin kernel.sin

CREATOR="SCRITCH007"
BRANDING_NAME="$CREATOR-BootManager"
VERSION="1.0"
DEVICE="X10"
ANDROID_VERSION="4.0.4"

echo "Manifest-Version: 1.0" > manifest.mf
echo "device: $DEVICE" >>  manifest.mf
echo "branding: $BRANDING_NAME-v$VERSION" >>  manifest.mf
echo "Created-By: $CREATOR" >>  manifest.mf
echo "version: $ANDROID_VERSION" >>  manifest.mf
jar cvfm0 kernel.jar manifest.mf loader.sin kernel.sin
mv kernel.jar "$DEVICE"_"$ANDROID_VERSION"_"$BRANDING_NAME"_v"$VERSION".ftf
rm manifest.mf
rm kernel.sin
