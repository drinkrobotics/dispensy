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

#echo "Generating plots"
rm -rf src/plot
#../hardware/generate_plot.sh
cp -r ../hardware/plot src

echo "Generating plot includes"
rm -rf src/inc_dispensy_sch.md
echo "<script src=\"js/svg-pan-zoom.js\" charset=\"UTF-8\"></script>" >> src/inc_dispensy_sch.md
for f in `ls src/plot/dispensy_sch.svg/*.svg | sort -r`; do
    file=`echo $f | sed 's:src/:./:g'`
    name=`echo $f | sed 's:src/plot/dispensy_sch.svg/::g' | sed 's:.svg::g'`
    echo $name
    echo "<h2>$name</h2>" >> src/inc_dispensy_sch.md
    echo "<div style=\"background-color: white;\">" >> src/inc_dispensy_sch.md
    echo "<embed type=\"image/svg+xml\" src=\"$file\" id=\"pz_$name\" style=\"width:100%;\"/>" >> src/inc_dispensy_sch.md
    echo "<script>" >> src/inc_dispensy_sch.md
    echo "document.getElementById('pz_$name').addEventListener('load', function(){" >> src/inc_dispensy_sch.md
    echo "svgPanZoom(document.getElementById('pz_$name'), {controlIconsEnabled: true});" >> src/inc_dispensy_sch.md
    echo "})" >> src/inc_dispensy_sch.md
    echo "</script>" >> src/inc_dispensy_sch.md
    echo "</div>" >> src/inc_dispensy_sch.md
    echo >> src/inc_dispensy_sch.md
    echo "[Direct link to \`$name\`]($file)." >> src/inc_dispensy_sch.md
    echo >> src/inc_dispensy_sch.md
done

echo "Preparing modelview dependencies"
cd modelview
sed -i 's/info\.inner/info_elem\.inner/g' modelview.js
./fetch_deps.sh
cd ..
rm -rf src/js/deps
cp -r modelview/deps src/js

echo "Generating docs"
if [ "$1" = "serve" ] ; then
    mdbook serve --open
elif [ "$1" = "build" ] ; then
    mdbook build
else
    echo "Invalid command. 'build' or 'serve'."
fi
