#!/bin/bash

function extract {
	#Copy the zImage
	cp $1/arch/arm/boot/zImage .
	./bin2elf 2 0x20008000 zImage 0x20008000 0x0 ramdisk 0x24000000 0x80000000
	./bin2sin result.elf 03000000220000007502000062000000
	rm result.elf
	#Now the kernel.sin exists
	mv result.elf.sin kernel.sin
}
