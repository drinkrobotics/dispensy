#!/bin/bash

cd "$(dirname "$0")"

echo "Generating plots"
rm -rf src/plot
../hardware/generate_plot.sh
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
done

echo "Generating docs"
if [ "$1" = "serve" ] ; then
    mdbook serve --open
elif [ "$1" = "build" ] ; then
    mdbook build
else
    echo "Invalid command. 'build' or 'serve'."
fi
