# Clip Studio Paint Thumbnailer for Linux

Unofficial thumbnail extractor for .clip files.

A lightweight thumbnailer for `.clip` files (Clip Studio Paint). This tool allows Linux file managers (Nemo, Nautilus, Thunar, etc.) to display canvas thumbnails natively.

## Why, when CSP is for windows?

I still need to organize my old art files even after migrating to linux!

## How it Works

Clip Studio files use the proprietary CSF Celsys Format. Inside this container sits an SQLite database that holds the canvas preview.

The extraction is fairly straight forward:
1. Locate the database by using grep to find the exact byte offset of the internal database.
2. Then use dd with and skip directly to where the database sits in the file.
3. Finally query the SQLite `CanvasPreview` table to output the raw PNG data.

Simply put, it searches and extracts an existing PNG preview in the `.clip` file.

The installation also includes registration of a mime type `application/x-clip` and the thumbnailer.

# Installation

## Dependencies

Ensure you have the following installed (standard on most distros):
`sqlite3`, `grep`, `coreutils` (for dd)

On Linux Mint/Ubuntu/Debian:
```bash
sudo apt install sqlite3 coreutils
```

## Install

Clone the repository and run the install script:
```bash
git clone https://github.com/ludospex/clipstudio-thumbnailer
cd clipstudio-thumbnailer
sudo bash install.sh
```

3. Refresh File Manager

To see the changes immediately, clear your thumbnail cache and restart your file manager:
```bash
rm -rf ~/.cache/thumbnails/*
nemo -q  # Or nautilus -q, thunar -q
```

## Uninstall

Because install.sh is run with sudo, check install.sh to verify the exact target paths used on your system before deleting files.

Remove the thumbnailer configuration and script/binary:
```bash
sudo rm -i /usr/share/thumbnailers/*clip* /usr/local/bin/*clip* 2>/dev/null
rm -i ~/.local/share/thumbnailers/*clip* ~/.local/bin/*clip* 2>/dev/null
```


