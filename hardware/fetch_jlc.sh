#!/bin/bash

# https://github.com/TousstNicolas/JLC2KiCad_lib

JLC2KiCadLib \
    C2040 \
    C113767 \
    C26537 \
    C22452 \
    C132227 \
    C86580 \
    C194472 \
    C134092 \
    C386740 \
    -dir jlc_lib \
    -schematic_lib jlc_schematics \
    -footprint_lib jlc_footprints \
    --skip_existing

