#!/bin/bash
FORGE_VERSION="1.7.10-10.13.3.1408-1.7.10"
MODPACK_DIR="/opt/modpack-dhv"
FORGE_DIR="/data/forge"

## Download Forge Installer
mkdir -p $FORGE_DIR
cd $FORGE_DIR
curl "http://files.minecraftforge.net/maven/net/minecraftforge/forge/${FORGE_VERSION}/forge-${FORGE_VERSION}-installer.jar" > $FORGE_DIR/forge-${FORGE_VERSION}-installer.jar

# Run forge installer in /data/forge
if [ ! -f "${FORGE_DIR}/forge-${FORGE_VERSION}-universal.jar" ]; then
    java -jar $FORGE_DIR/forge-${FORGE_VERSION}-installer.jar --installServer
fi

# Symlink everything in the modpack
SYMLINKS=("assets" "config" "mods" "resources" "server.properties" "toolkit" "eula.txt")
for f in "${SYMLINKS[@]}"
do
    if [ ! -L "${MODPACK_DIR}/${f}" ]; then
        ln -sf $MODPACK_DIR/$f $FORGE_DIR/$f
    fi
done

# Remove clientside mods
rm -rf $MODPACK_DIR/mods/InventoryTweaks-1.58-147.jar
rm -rf $MODPACK_DIR/mods/AnimationAPI-1.7.10-1.2.4.jar
rm -rf $MODPACK_DIR/mods/JourneyMap5.0.1_Unlimited_MC1.7.10.jar
rm -rf $MODPACK_DIR/mods/ResourceLoader-1.2.jar
rm -rf $MODPACK_DIR/mods/CustomMainMenu-MC1.7.10-1.5.jar

# Run via RemoteToolkit
java -Xmx30M -Xms30M -XX:MaxPermSize=40M -jar $FORGE_DIR/toolkit/wrapper.jar -hold
