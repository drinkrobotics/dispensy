#!/bin/bash

cd "$(dirname "$0")"

INFILE="dispensy.kicad_pcb"
INFILE_SCH="dispensy.kicad_sch"
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

echo "Exporting BOM files"
kicad-cli sch export python-bom -o $OUTDIR/bom.xml $INFILE_SCH

# TODO convert BOM XML to proper format for JLCPCB

echo "Compressing archive"
rm -rf $OUTZIP.zip
zip -r $OUTZIP fabrication
