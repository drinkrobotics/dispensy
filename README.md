# Dispensy

![PCB](https://github.com/drinkrobotics/dispensy/actions/workflows/kicad.yml/badge.svg)
![Docs](https://github.com/drinkrobotics/dispensy/actions/workflows/docs.yml/badge.svg)
![Firmware](https://github.com/drinkrobotics/dispensy/actions/workflows/cmake.yml/badge.svg)

One day aims to be a new hardware base for the [DrinkRobotics UbaBot](https://www.xythobuz.de/drinkrobotics.html).

Check out the [Dispensy documentation](https://drinkrobotics.github.io/dispensy/).

## License

This hardware of this project is licensed under the [CERN Open Hardware Licence Version 2 - Strongly Reciprocal (CERN-OHL-S-2.0+)](https://ohwr.org/cern_ohl_s_v2.txt) or any later version.

The docs are built using [mdbook](https://github.com/rust-lang/mdBook), licensed as `MPL-2.0`.
The PCB SVG files in the documentation are displayed using [svg-pan-zoom](https://github.com/bumbu/svg-pan-zoom), licensed as `BSD-2-Clause`.
The 3D PCB files in the documentation are displayed using [three.js](hhttps://github.com/mrdoob/three.js), licensed as `MIT`.

Please also take a look at the `README.md` files in the subfolders of this project for more info.

     ------------------------------------------------------------------------------
    | Copyright (c) 2023 - 2024 Thomas Buck <thomas@xythobuz.de>                   |
    |                                                                              |
    | This source describes Open Hardware and is licensed under the CERN-OHL-S v2  |
    | or any later version.                                                        |
    |                                                                              |
    | You may redistribute and modify this source and make products using it under |
    | the terms of the CERN-OHL-S v2 (https://ohwr.org/cern_ohl_s_v2.txt)          |
    | or any later version.                                                        |
    |                                                                              |
    | This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,          |
    | INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A         |
    | PARTICULAR PURPOSE. Please see the CERN-OHL-S v2 (or any later version)      |
    | for applicable conditions.                                                   |
    |                                                                              |
    | Source location: https://github.com/drinkrobotics/dispensy                   |
    |                                                                              |
    | As per CERN-OHL-S v2 section 4, should You produce hardware based on this    |
    | source, You must where practicable maintain the Source Location visible      |
    | on the external case of the Gizmo or other products you make using this      |
    | source.                                                                      |
     ------------------------------------------------------------------------------

The firmware of this project is licensed as GPLv3.
I initially adapted it from my own [Trackball](https://git.xythobuz.de/thomas/Trackball) and [Volcano Remote](https://git.xythobuz.de/thomas/sb-py) projects.
It uses the [Pi Pico SDK](https://github.com/raspberrypi/pico-sdk), licensed as BSD 3-clause, and therefore also [TinyUSB](https://github.com/hathach/tinyusb), licensed under the MIT license.
Some code is adapted from the TinyUSB examples.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    See <http://www.gnu.org/licenses/>.
