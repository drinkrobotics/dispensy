#!/bin/bash

cd "$(dirname "$0")"

INFILE="dispensy.kicad_pcb"
OUTDIR="fabrication"
OUTZIP="fab"

echo "Creating output directory"
rm -rf $OUTDIR
mkdir -p $OUTDIR

echo "Exporting drill files"
#kicad-cli pcb export drill -o $OUTDIR/ --format excellon --generate-map --map-format pdf $INFILE
kicad-cli pcb export drill -o $OUTDIR/ --format gerber --generate-map --map-format gerberx2 $INFILE

echo "Exporting gerber files"
#kicad-cli pcb export gerbers -o $OUTDIR/ $INFILE
kicad-cli pcb export gerbers -o $OUTDIR/ -l F.Cu,B.Cu,F.Mask,B.Mask,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,Edge.Cuts $INFILE

# TODO BOM for JLCPCB assembly service

echo "Compressing archive"
rm -rf $OUTZIP.zip
zip -r $OUTZIP fabrication
