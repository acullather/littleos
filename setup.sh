#!/bin/bash
mkdir -p iso/boot/grub              # create the folder structure
cp stage2_eltorito iso/boot/grub/   # copy the bootloader
cp kernel.elf iso/boot/             # copy the kernel
