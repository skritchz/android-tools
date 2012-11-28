#!/bin/bash

CONFIG_FOLDER=~/.config/scritch
CONFIG_FILE=$CONFIG_FOLDER/config.sh

function init_config {

    if [ ! -d $CONFIG_FOLDER ]; then
        mkdir $CONFIG_FOLDER
    fi
    
    if [ ! -f $CONFIG_FILE ]; then
        echo "#!/bin/bash" > $CONFIG_FILE
    fi
    
    source $CONFIG_FILE

}

function check_config {

    if [ ! -f $CONFIG_FILE ]; then
        echo "Please configure your computer by running the init script once!"
        echo "cd ../scripts"
        echo "./init.sh"
        exit 1
    fi

    source $CONFIG_FILE
}

