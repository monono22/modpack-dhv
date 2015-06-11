#!/bin/bash
FORGE_VERSION="1.7.10-10.13.3.1408-1.7.10"

## Download Forge Installer
mkdir -p /data/forge
curl "http://files.minecraftforge.net/maven/net/minecraftforge/forge/${FORGE_VERSION}/forge-${FORGE_VERSION}-installer.jar" > /data/forge/forge-${FORGE_VERSION}-installer.jar

# Run forge installer in /data/forge
pushd /data/forge
java -jar /data/forge/forge-${FORGE_VERSION}-installer.jar --installServer
