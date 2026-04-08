#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root (sudo ./install.sh)"
  exit
fi

echo "Installing Clip Studio Thumbnailer..."

# Check for dependencies
for cmd in sqlite3 grep dd; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed. Please install it first."
        exit 1
    fi
done

cp clipstudio-thumbnailer.sh /usr/local/bin/clipstudio-thumbnailer
chmod +x /usr/local/bin/clipstudio-thumbnailer

cp clipstudio.thumbnailer /usr/share/thumbnailers/
cp clipstudio.xml /usr/share/mime/packages/

echo "Updating MIME database..."
update-mime-database /usr/share/mime

echo "Done! Restart Nemo (nemo -q) to see thumbnails."
