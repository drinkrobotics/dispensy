#!/bin/bash

cd "$(dirname "$0")"

echo "Generating plots"
rm -rf src/plot
../hardware/generate_plot.sh
cp -r ../hardware/plot src

echo "Generating plot includes"
rm -rf src/inc_dispensy_sch.md
for f in src/plot/dispensy_sch.svg/*.svg; do
    file=`echo $f | sed 's:src/:./:g'`
    name=`echo $f | sed 's:src/plot/dispensy_sch.svg/::g' | sed 's:.svg::g'`
    echo "<h2>$name</h2>" >> src/inc_dispensy_sch.md
    echo "<div style=\"background-color: white;\">" >> src/inc_dispensy_sch.md
    echo "<a href=\"$file\">" >> src/inc_dispensy_sch.md
    echo "<img src=\"$file\" alt=\"Main-Board PCB layout as SVG\">" >> src/inc_dispensy_sch.md
    echo "</a></div>" >> src/inc_dispensy_sch.md
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
