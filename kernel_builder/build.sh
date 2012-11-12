#!/bin/bash

#Include the arguments parse before
source scripts/parser.sh


CREATOR="SCRITCH007"
BRANDING_NAME="$CREATOR-BootManager"

echo $VERSION

if [ -z ${VERSION} ]; then
	VERSION="1.0"
else
	echo "Using passed version $VERSION"
fi
DEVICE="X10"
ANDROID_VERSION="4.0.4"

echo "Manifest-Version: 1.0" > manifest.mf
echo "device: $DEVICE" >>  manifest.mf
echo "branding: $BRANDING_NAME-v$VERSION" >>  manifest.mf
echo "Created-By: $CREATOR" >>  manifest.mf
echo "version: $VERSION" >>  manifest.mf
jar cvfm0 kernel.jar manifest.mf loader.sin kernel.sin
mv kernel.jar "$DEVICE"_"$ANDROID_VERSION"_"$BRANDING_NAME"_v"$VERSION".ftf
rm manifest.mf
rm kernel.sin
