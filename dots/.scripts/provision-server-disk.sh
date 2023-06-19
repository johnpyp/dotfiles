#!/usr/bin/env bash
#

DISK_PATH=$1
DISK_LABEL=$2

echo "Step 1: Add GPT"
echo "---------------"
echo "Use: sudo gdisk $1"
echo " -> o to create a new GUID Partition Table (GPT)"
echo " -> Enter"
echo " -> w to write & exit"
echo "---------------"
echo ""


echo "Step 2: Create a new partition filling volume of the drive"
echo "---------------"
echo "Use: sudo gdisk $1"
echo " -> n to create a new partition"
echo " -> Enter for default partition number (1)"
echo " -> Enter for default first sector (1)"
echo " -> Enter for default last sector (to use entire disk)"
echo " -> 8300 for Linux filesystem type"
echo " -> w to write & exit"
echo "---------------"
echo ""

echo "Step 3: Create an ext4 filesystem with label"
echo "---------------"
echo "Use: sudo mkfs.ext4 -L $2 ${1}1"
echo " - This will create the ext4 filesytem and set the label. A UUID will be automatically generated."
echo "---------------"
echo ""

echo "Step 4: Confirm new device configuration"
echo "---------------"
echo "Use: sudo blkid $1"
echo "You should see something similar to:"
echo "/dev/sdm1: LABEL="disk_18tb_2" UUID="e38d69f4-dc43-4a63-a71f-412542969818" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="c53d6c98-b206-0c4c-ac13-82cd03f51c0d""
echo ""
echo "Done!"

