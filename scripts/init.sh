#!/bin/bash

source config.sh

init_config

if [ -z $SCRITCH_SCRIPT_CREATOR ]; then
SCRITCH_SCRIPT_CREATOR=`whoami`
fi


function set_value {

    key_value=$1
    key=$2
    default_value=$3
    echo "Please enter $key [current:$default_value] " 
    read str
    value=$default_value
    if [[ -n ${str} ]]; then
        value=$str
    fi
    echo "$key_value"=$value >> $CONFIG_FILE
    eval "$1=$value"
}

set_value SCRITCH_SCRIPT_CREATOR "Creator Name" $SCRITCH_SCRIPT_CREATOR 

if [ -z $SCRITCH_SCRIPT_BRANDING_NAME ]; then
SCRITCH_SCRIPT_BRANDING_NAME=$SCRITCH_SCRIPT_CREATOR"_BootManager"
fi
set_value SCRITCH_SCRIPT_BRANDING_NAME "Brading Name" $SCRITCH_SCRIPT_BRANDING_NAME 

set_value SCRITCH_SCRIPT_VERSION "Version" $SCRITCH_SCRIPT_VERSION 

if [ -z $SCRITCH_SCRIPT_ROM_PATH ]; then
SCRITCH_SCRIPT_ROM_PATH=$HOME/android/system/
fi
set_value SCRITCH_SCRIPT_ROM_PATH "android rom base" $SCRITCH_SCRIPT_ROM_PATH

if [ -z $SCRITCH_SCRIPT_PLATFORM_TOOLS ]; then
SCRITCH_SCRIPT_PLATFORM_TOOLS=$HOME/android-sdks/platform-tools/
fi
set_value SCRITCH_SCRIPT_PLATFORM_TOOLS "adb folder" $SCRITCH_SCRIPT_PLATFORM_TOOLS



RESPONSE=''
until [ -z RESPONSE ]; do

    echo "Do you which to edit .bashrc to add required definitions?[default:Y] [Y/N]"
    read str
    case $str in
        Y )
        in_my_case=false
        mv ~/.bashrc ~/.bashrc.old
        start_line=`grep -n "#START_SCRITCH_DEFINITIONS" ~/.bashrc.old | cut -d":" -f1`
        stop_line=`grep -n "#STOP_SCRITCH_DEFINITIONS" ~/.bashrc.old | cut -d":" -f1`
        if [[ -n ${start_line} ]]; then
            
            sed "$start_line,$stop_line""d" ~/.bashrc.old > ~/.bashrc
        else
            cp ~/.bashrc.old ~/.bashrc
        fi
        echo "#START_SCRITCH_DEFINITIONS" >> ~/.bashrc
        echo "#DO NOT EDIT LINES IN HERE MANUALLY USE THE init.sh script" >> ~/.bashrc
        echo "PATH=$SCRITCH_SCRIPT_PLATFORM_TOOLS:\$PATH" >> ~/.bashrc
        echo "PATH=$PWD:\$PATH" >> ~/.bashrc
        echo "PATH=$SCRITCH_SCRIPT_ROM_PATH/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin:\$PATH" >> ~/.bashrc
        echo "PATH=$PWD/../bin:\$PATH" >> ~/.bashrc
        echo "#STOP_SCRITCH_DEFINITIONS" >> ~/.bashrc
        break
        ;;
        N )
        break 
        ;;

        * )
        ;;

    esac
done

echo "************************************************"
echo "*          Configuration is completed.         *"
echo "* Before anything please type:                 *"
echo "*          source ~/.bashrc                    *"
echo "************************************************"

