#!/bin/bash

#Include the arguments parse before
source scripts/parser.sh


DEVICE="X10"

if [ -z ${VERSION} ]; then
	VERSION="1.0"
else
	echo "Using passed version $VERSION"
fi
if [ -z ${ANDROID_VERSION} ]; then
    ANDROID_VERSION="4.0.4"
fi

echo "Manifest-Version: 1.0" > manifest.mf
echo "device: $DEVICE" >>  manifest.mf
echo "branding: $ANDROID_VERSION-v$VERSION" >>  manifest.mf
echo "Created-By: $SCRITCH_SCRIPT_CREATOR" >>  manifest.mf
echo "version: $VERSION" >>  manifest.mf
jar cvfm0 kernel.jar manifest.mf loader.sin kernel.sin
mv kernel.jar "$DEVICE"_"$ANDROID_VERSION"_"$SCRITCH_SCRIPT_BRANDING_NAME"_v"$VERSION".ftf
rm manifest.mf
rm kernel.sin
