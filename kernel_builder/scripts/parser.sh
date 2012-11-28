#!/bin/bash


source ../scripts/config.sh

check_config

function help {
	echo '--help|-h to display this help'
	echo "--rom|-r [path] for using kernel provided in the rom"
	echo "--kernel|-k [path] to use kernel built from sources"
	echo "--credits to display credits"
    echo "--android|-a [android_version] default 4.0.4"
    echo "--version|-a [version] kernel version"
}


if [ "$#" = "0" ]; then
	help
	exit 1
fi


config_correct=false

_extract_parameter=""

until [ -z "$1" ]; do
	# use a case statement to test vars. we always test
	# test $1 and shift at the end of the for block.
	case $1 in
		--help|-h )
			help
			exit 0
		;;
		--rom|-r )
			# set to 1 for later testing
			shift
            _extract_parameter=$1
			if $config_correct; then
				echo "Kernel has already been configured"
				exit 1
			fi
			config_correct=true
			source scripts/from_zip.sh 
		;;
		--kernel|-k )
			shift
			if $config_correct; then
				echo "Kernel has already been configured"
				exit 1
			fi
			config_correct=true
            _extract_parameter=$1
			source scripts/from_sources.sh
		;;
		--credits )
			source scripts/credits.sh
			exit 0
		;;

        --android|-a )
            shift
            ANDROID_VERSION=$1

        ;;
		--version|-v )
			#This will be added as the version for the Manifest
			shift
			VERSION=$1
		;;
		-* )
			echo "Unrecognized option: $1"
			exit 1
		;;
		* )
			echo "Missing parameters"
			help
			exit 1
		;;
	esac

	shift

	if [ "$#" = "0" ]; then
		break
	fi
done

extract $_extract_parameter
