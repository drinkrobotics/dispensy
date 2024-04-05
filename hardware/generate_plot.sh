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

INSCH="dispensy.kicad_sch"
INPCB="dispensy.kicad_pcb"
OUTDIR="plot"
LAYER_F="F.Cu,F.Mask,F.Paste,F.Silkscreen,Edge.Cuts,User.Drawings"
LAYER_B="B.Cu,B.Mask,B.Paste,B.Silkscreen,Edge.Cuts,User.Drawings"

cd "$(dirname "$0")"
rm -rf $OUTDIR
mkdir -p $OUTDIR

#  --------------
# | 2D Schematic |
#  --------------

for IN in $INSCH
do
    echo "Exporting schematic $IN"

    for TYPE in pdf svg
    do
        echo "Exporting schematic $TYPE"
        rm -rf $OUTDIR/$IN.$TYPE
        kicad-cli sch export $TYPE \
            -t "KiCad Default" \
            -o $OUTDIR/$IN.$TYPE \
            $IN
        echo
    done
done

for IN in $INPCB
do
    echo "Exporting board $IN"

    #  -----------
    # | 2D Layout |
    #  -----------

    for TYPE in pdf svg
    do
        rm -rf $OUTDIR/$IN.$TYPE
        mkdir -p $OUTDIR/$IN.$TYPE

        echo "Exporting board $TYPE"
        kicad-cli pcb export $TYPE \
            -t "KiCad Classic"  \
            -l $LAYER_B,$LAYER_F \
            -o $OUTDIR/$IN.$TYPE/0_both.$TYPE \
            $IN
        echo

        echo "Exporting board front $TYPE"
        kicad-cli pcb export $TYPE \
            -t "KiCad Classic"  \
            -l $LAYER_F \
            -o $OUTDIR/$IN.$TYPE/1_front.$TYPE \
            $IN
        echo

        echo "Exporting board back $TYPE"
        kicad-cli pcb export $TYPE \
            -t "KiCad Classic"  \
            -l $LAYER_B \
            -o $OUTDIR/$IN.$TYPE/2_back.$TYPE \
            $IN
        echo
    done

    echo "Concatenating board PDFs"
    mv $OUTDIR/$IN.pdf $OUTDIR/$IN.tmp
    pdfunite $OUTDIR/$IN.tmp/*.pdf $OUTDIR/$IN.pdf
    rm -rf $OUTDIR/$IN.tmp

    #  -----------
    # | 3D Export |
    #  -----------

    echo "Exporting board 3D"
    kicad-cli pcb export vrml \
        -o $OUTDIR/$IN.wrl \
        $IN
done
