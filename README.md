# FreezyOS - A Journey Through OS Development
---

## About FreezyOS
FreezyOS is based on the "from scratch" operating system described in Nick Blundell's _"Writing a Simple Operating System - From Scratch"_
https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf

## Try It
To run FreezyOS you can write `boot_sect.bin` to an actual disk and boot a real x86 machine from it, which I very much don't recommend.

The better option is to install [Qemu](https://www.qemu.org/download/)

Then run the emulator with the following command:
`qemu-system-i386 -drive file=boot_sect.bin,format=raw,index=0,media=disk`