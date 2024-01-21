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

cd "$(dirname "$0")"

OUTDIR="plot"
LAYER="F.Cu,B.Cu,F.Mask,B.Mask,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,Edge.Cuts,User.Drawings"

rm -rf $OUTDIR
mkdir -p $OUTDIR

for VAR in pdf svg
do
    echo "Exporting schematic $VAR"
    rm -rf $OUTDIR/dispensy_sch.$VAR
    kicad-cli sch export $VAR \
        -t "KiCad Default" \
        -o $OUTDIR/dispensy_sch.$VAR \
        dispensy.kicad_sch

    echo "Exporting board $VAR"
    rm -rf $OUTDIR/dispensy_pcb.$VAR
    kicad-cli pcb export $VAR \
        -t "KiCad Classic"  \
        -l $LAYER \
        -o $OUTDIR/dispensy_pcb.$VAR \
        dispensy.kicad_pcb
    echo
done

echo "Exporting board step file"
rm -rf $OUTDIR/dispensy_pcb.step
kicad-cli pcb export step \
    -o $OUTDIR/dispensy_pcb.step \
    dispensy.kicad_pcb

echo "Converting step to 3mf"
rm -rf $OUTDIR/dispensy_pcb.3mf
prusa-slicer --export-3mf $OUTDIR/dispensy_pcb.step

echo "Deleting step file"
rm -rf $OUTDIR/dispensy_pcb.step
