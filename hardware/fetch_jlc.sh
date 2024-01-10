#!/bin/bash

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
    C132227  `# ` \
    C86580   `# ` \
    C194472  `# ` \
    C134092  `# ` \
    C386740  `# ` \
    C148313  `# ` \
    C279981  `# ` \
    C140675  `# ` \
    C409700  `# ` \
    C172043  `# ` \
    C105883  `# ` \
    C83063   `# ` \
    C2920042 `# ` \
    C520861  `# ` \
    C406733  `# ` \
    C380316  `# ` \
    C144787  `# ` \
    C2937625 `# ` \
    C234182  `# ` \
    C146690  `# ` \
    C40877   `# ` \
    C144481  `# ` \
    C697422  `# ` \
    C237221  `# ` \
    C106200  `# ` \
    C5613    `# ` \
    C2909114 `# ` \
    C475721  `# ` \
    C497903  `# ` \
    C249838  `# ` \
    C310843  `# ` \
    -dir jlc_lib \
    -symbol_lib jlc_schematics \
    -symbol_lib_dir Schematic \
    -footprint_lib jlc_footprints \
    --skip_existing
