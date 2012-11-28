#!/bin/bash

function extract {
	#extract kernel.sin from provided rom
	echo "Extraction kernel.sin from $1"
	unzip $1 kernel.sin
}
