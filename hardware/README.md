# Hardware

This is a KiCAD 7 hierarchical schematic and layout.
Take a look at the [docs](https://docs.kicad.org/7.0/en/eeschema/eeschema.html#hierarchical-schematics).

The repeated schematic sheets can also be replicated in the layout using [this plugin](https://github.com/MitjaNemec/ReplicateLayout).

To fetch symbols, footprints and 3d models automatically from [the JLCPCB parts library](https://jlcpcb.com/parts), [JLC2KiCad_lib](https://github.com/TousstNicolas/JLC2KiCad_lib) is used with the `fetch_jlc.sh` script.
To get the 3D models to have the correct offsets I used [this forked version](https://github.com/Xyntexx/JLC2KiCad_lib/tree/footprint_alignment_workarounds):

    pipx install git+https://github.com/Xyntexx/JLC2KiCad_lib.git@footprint_alignment_workarounds

In the future this may no longer be needed.

## External Libs

Uses SSD1306 lib from [KiCAD Rookie](https://kicadrookie.blogspot.com/2022/06/ssd1306-i2c-096in-oled-display-kicad_86.html).
