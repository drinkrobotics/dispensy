#!/bin/bash

# SPDX-FileCopyrightText: 2023 - 2024 Thomas Buck <thomas@xythobuz.de>
# SPDX-License-Identifier: CERN-OHL-S-2.0+
#
#  ------------------------------------------------------------------------------
# | Copyright (c) 2023 - 2024 Thomas Buck <thomas@xythobuz.de>                   |
# |                                                                              |
# | This source describes Open Hardware and is licensed under the CERN-OHL-S v2  |
# | or any later version.                                                        |
# |                                                                              |
# | You may redistribute and modify this source and make products using it under |
# | the terms of the CERN-OHL-S v2 (https://ohwr.org/cern_ohl_s_v2.txt)          |
# | or any later version.                                                        |
# |                                                                              |
# | This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,          |
# | INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A         |
# | PARTICULAR PURPOSE. Please see the CERN-OHL-S v2 (or any later version)      |
# | for applicable conditions.                                                   |
# |                                                                              |
# | Source location: https://github.com/drinkrobotics/dispensy                   |
# |                                                                              |
# | As per CERN-OHL-S v2 section 4, should You produce hardware based on this    |
# | source, You must where practicable maintain the Source Location visible      |
# | on the external case of the Gizmo or other products you make using this      |
# | source.                                                                      |
#  ------------------------------------------------------------------------------

# https://github.com/TousstNicolas/JLC2KiCad_lib

# enter directory of script
cd "$(dirname "$0")"

# create output directory
mkdir -p jlc_lib

# fetch / update parts libs
JLC2KiCadLib \
    C2040    `# RP2040` \
    C113767  `# W25Q128JVSIQ 128Mbit SPI NOR FLASH` \
    C26537   `# NCP1117ST33T3G 3.3V 1A LDO !! LOW STOCK !!` \
    C22452   `# SS54 40V 5A Schottky Barrier Diode` \
    C132227  `# TJA1042T/3/1J CAN Transceiver` \
    C86580   `# DS1129-05-S80BP-X RJ45 2x Socket` \
    C194472  `# LM2576S-5.0/TR Step Down` \
    C134092  `# Molex USB-C Socket` \
    C386740  `# USB-A Female` \
    C148313  `# ABM3-12.000MHZ-D2Y-T 12MHz Ceramic Resonator` \
    C279981  `# 1kΩ 0402 62.5mW ±1%` \
    C140675  `# 27pF 0402 50V Ceramic Capacitor` \
    C409700  `# 5.1kΩ 0402 62.5mW ±1%` \
    C172043  `# 27.4Ω 0402 62.5mW ±1%` \
    C105883  `# 100nF 0402 25V Ceramic Capacitor` \
    C83063   `# 1uF 0402 16V Ceramic Capacitor` \
    C2920042 `# WS2812E-V5 RGB LED` \
    C520861  `# SPST Tactile Switch` \
    C406733  `# 10kΩ 0402 62.5mW ±1%` \
    C380316  `# 10uF 0603 10V Ceramic Capacitor` \
    C144787  `# 1MΩ 0402 62.5mW ±1%` \
    C2937625 `# Straight Square Pins 2.54mm 3P` \
    C234182  `# Straight Square Pins 2.54mm 2P` \
    C146690  `# Female Header 2.54mm 3P` \
    C40877   `# Female Header 2.54mm 6P` \
    C144481  `# 60.4Ω 1206 250mW ±1%` \
    C697422  `# 47nF 0402 50V Ceramic Capacitor` \
    C237221  `# 4.7nF 0402 50V Ceramic Capacitor` \
    C106200  `# 100pF 0402 50V Ceramic Capacitor` \
    C5613    `# 74HC165D Parallel to Serial Shift Register` \
    C2909114 `# SMD Rotary Encoder` \
    C475721  `# MBR340F 40V 3A Schottky Barrier Diode` \
    C497903  `# Inductor 100uH ±20% 2A` \
    C249838  `# 100uF 80V Electrolytic Capacitor` \
    C310843  `# 1000uF 16V Electrolytic Capacitor` \
    C496132  `# 1x4P Barrier Block 7.62mm 20A 300V` \
    C347222  `# AMS1117-3.3 3.3V 1A LDO` \
    -dir jlc_lib \
    -symbol_lib jlc_schematics \
    -symbol_lib_dir Schematic \
    -footprint_lib jlc_footprints \
    --skip_existing
