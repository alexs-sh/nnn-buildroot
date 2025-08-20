#!/bin/bash

DEFCONFIG=qemu_aarch64_virt_defconfig
MODE=defaut

if [ "$#" -ge 1 ]; then
   DEFCONFIG=$1
fi

if [ "$#" -ge 2 ]; then
   MODE=$2
fi


readonly BR_CONFIG=buildroot/configs/"$DEFCONFIG"

set -e
. "$HOME/.cargo/env"

echo "Add config $DEFCONFIG"
cp configs/"$DEFCONFIG" "$BR_CONFIG"

if [ "$MODE" == "with-readline" ]; then
   echo "Add readline library"
   echo "BR2_PACKAGE_READLINE=y" >> "$BR_CONFIG"
fi

echo "Apply config $DEFCONFIG"
cd buildroot
make "$DEFCONFIG"

echo "Build"
export FORCE_UNSAFE_CONFIGURE=1
make
cd -

echo "Pack"
tar -cvzf images.tar.gz -C buildroot/output/  images

echo "Done"
