#!/bin/bash
echo "####### CYCLE COUNT #######"
ioreg -c IOACPIPlatformDevice -rln "SMB0" | grep "Cycle Count"
echo "####### MAX CYCLE COUNT #######"
ioreg -c AppleSmartBattery | grep "DesignCycleCount"
echo "####### BATTERY HEALTH #######"
ioreg -c IOACPIPlatformDevice -rln "SMB0" | awk '{{if ($1 ~ /MaxCapacity/) maxcap=$3; else if ($1 ~ /DeviceCapacity/) descap=$3} {if (maxcap != 0) {if (descap != 0) print (maxcap*100)/descap}}}' | grep -m 1 .
echo "####### GPU #######"
ioreg -c IOPCIDevice -rn "GFX0" | grep "model"
echo "####### CPU #######"
sysctl -n machdep.cpu.brand_string
echo "####### RAM #######"
sysctl hw.memsize | awk '{ mem_bytes=0; print mem_bytes/1024/1024/1024, "GB" }'
echo "####### HDD #######"
diskutil list disk0
diskutil quiet erasedisk APFS "Macintosh HD" /dev/disk0
echo "####### HDD FORMATTED #######"
echo "####### SERIAL NUMBER #######"
ioreg -c IOPlatformExpertDevice -r | grep "IOPlatformSerialNumber"
