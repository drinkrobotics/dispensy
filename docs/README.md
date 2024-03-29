# Dispensy Documentation

You can find the [documentation here on GitHub pages](https://drinkrobotics.github.io/dispensy/).
This file is intended for contributors that want to modify this website!

## Dependencies

The PCB SVG files are displayed using [svg-pan-zoom](https://github.com/bumbu/svg-pan-zoom), licensed as `BSD-2-Clause`.
The 3D PCB files are displayed using [modelview](https://github.com/jschobben/modelview), licensed as `MIT`.
Fetch the included git submodules after cloning this repository before working on the docs.

    git submodule update --init

## Local Build

The docs are built using [mdbook](https://github.com/rust-lang/mdBook), licensed as `MPL-2.0`.
Get the [latest release from GitHub](https://github.com/rust-lang/mdBook/releases) for a pre-built binary if you want to test changes to the docs locally.

    ./docs/generate_docs.sh serve

This will open your browser to a local development instance of the docs.
