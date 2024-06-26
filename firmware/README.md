# Dispensy Firmware

TODO

## Quick Start

When compiling for the first time, check out the required git submodules.

    git submodule update --init
    cd pico-sdk
    git submodule update --init

Then do this to build.

    mkdir build
    cmake -B build
    make -C build -j4

And flash the resulting `dispensy.uf2` file to your Pico as usual.

For convenience you can use the included `flash.sh`, as long as you flashed the binary manually once before.

    make -C build -j4
    ./flash.sh build/dispensy.uf2

This will use the mass storage bootloader to upload a new uf2 image.

For old-school debugging a serial port will be presented by the firmware.
Open it using eg. `picocom`, or with the included `debug.sh` script.

For dependencies to compile, on Arch install these.

    sudo pacman -S arm-none-eabi-gcc arm-none-eabi-newlib picocom cmake cxxtest

## Proper Debugging

You can also use the SWD interface for proper hardware debugging.

This follows the instructions from the [RP2040 Getting Started document](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf) from chapter 5 and 6.

For ease of reading the disassembly, create a debug build.

    mkdir build_debug
    cmake -B build_debug -DCMAKE_BUILD_TYPE=Debug
    make -C build -j4

You need a hardware SWD probe.
This can be made from another Pico, see Appendix A in the document linked above.
For this you need to compile the `picoprobe` firmware, like this.

    git clone https://github.com/raspberrypi/picoprobe.git
    cd picoprobe

    git submodule update --init
    mkdir build
    cd build

    PICO_SDK_PATH=../../../pico-sdk cmake ..
    make -j4

    cd ../.. # back to build_debug directory from before

And flash the resulting `picoprobe.uf2` to your probe.
Connect `GP2` of the probe to `SWCLK` of the target and `GP3` of the probe to `SWDIO` of the target.
Of course you also need to connect GND between both.

You need some dependencies, mainly `gdb-multiarch` and the RP2040 fork of `OpenOCD`.

    sudo apt install gdb-multiarch   # Debian / Ubuntu
    sudo pacman -S arm-none-eabi-gdb # Arch Linux

    git clone https://github.com/raspberrypi/openocd.git --branch rp2040 --recursive --depth=1
    cd openocd

    # install udev rules
    sudo cp contrib/60-openocd.rules /etc/udev/rules.d
    sudo udevadm control --reload-rules && sudo udevadm trigger

    ./bootstrap
    ./configure --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio
    make -j4

    cd .. # back to build_debug directory from before

Now we can flash a firmware image via OpenOCD.

    ./openocd/src/openocd -s openocd/tcl -f interface/cmsis-dap.cfg -f target/rp2040.cfg -c "adapter speed 5000" -c "cmsis_dap_vid_pid 0x2e8a 0x000c" -c "program gadget.elf verify reset exit"

And also start a GDB debugging session.

    ./openocd/src/openocd -s openocd/tcl -f interface/cmsis-dap.cfg -f target/rp2040.cfg -c "adapter speed 5000" -c "cmsis_dap_vid_pid 0x2e8a 0x000c"
    arm-none-eabi-gdb gadget.elf
    target extended-remote localhost:3333

    load # program elf into flash
    monitor reset init # put into clean initial state
    continue # start program

These commands have also been put in the `flash_swd.sh` and `debug_swd.sh` scripts, respectively.
They require the `build_debug` folder where you checked out and built OpenOCD.
Here are some [general GDB tips](https://beej.us/guide/bggdb/).
