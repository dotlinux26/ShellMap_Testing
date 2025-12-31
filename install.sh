#!/bin/bash



if [ "$EUID" -ne 0 ]; then

  echo "ERROR: Please run with admin sudo!"

  exit 1

fi



echo ">>> NOW INSTALLING SHELLMAP..."



if [ ! -f "shellmap_bin" ]; then

    echo "ERROR: Not found file 'shellmap_bin'!"

    exit 1

fi



INSTALL_DIR="/opt/shellmap"

echo "Create struct: $INSTALL_DIR/shellmap/"



rm -rf "$INSTALL_DIR"

mkdir -p "$INSTALL_DIR"



mkdir -p "$INSTALL_DIR/shellmap/shared"

mkdir -p "$INSTALL_DIR/shellmap/downloads"

mkdir -p "$INSTALL_DIR/shellmap/system"



echo "[!] Copy file..."





cp shellmap_bin "$INSTALL_DIR/shellmap_bin"

chmod +x "$INSTALL_DIR/shellmap_bin"



if [ -f "nodes.json" ]; then

    echo "Copy nodes.json to sub-folder..."

    cp nodes.json "$INSTALL_DIR/shellmap/nodes.json"

fi





echo "Create off EOF '/usr/local/bin/shellmap'..."



cat <<EOF > /usr/local/bin/shellmap

#!/bin/bash



cd $INSTALL_DIR

./shellmap_bin "\$@"

EOF



chmod +x /usr/local/bin/shellmap

chmod -R 777 "$INSTALL_DIR"



echo "========================================================"

echo "   DOWNLOAD COMPLETE!"

echo "   Data path: $INSTALL_DIR/shellmap/"

echo "   YOU CAN RUN WITH shellmap!"

echo "========================================================"