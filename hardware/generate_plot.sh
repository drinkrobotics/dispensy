#!/bin/bash

cd "$(dirname "$0")"

OUTDIR="plot"
LAYER="F.Cu,B.Cu,F.Mask,B.Mask,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,Edge.Cuts,User.Drawings,F.Fab,B.Fab"

rm -rf $OUTDIR
mkdir -p $OUTDIR

for VAR in pdf svg
do
    echo "Exporting schematic $VAR"
    rm -rf dispensy_sch.$VAR
    kicad-cli sch export $VAR \
        -t "KiCad Default" \
        -o $OUTDIR/dispensy_sch.$VAR \
        dispensy.kicad_sch

    echo "Exporting board $VAR"
    rm -rf dispensy_pcb.$VAR
    kicad-cli pcb export $VAR \
        -t "KiCad Classic"  \
        -l $LAYER \
        -o $OUTDIR/dispensy_pcb.$VAR \
        dispensy.kicad_pcb
done
