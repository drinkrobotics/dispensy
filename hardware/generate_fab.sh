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
