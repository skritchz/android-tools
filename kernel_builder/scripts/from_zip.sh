#!/bin/bash

function extract {
	#extract kernel.sin from provided rom
	echo "Extraction kernel.sin from $ROM_PATH"
	unzip $ROM_PATH kernel.sin
}
