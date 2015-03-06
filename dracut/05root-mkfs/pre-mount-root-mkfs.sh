#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

# Usage: cmdline_arg name default_value
cmdline=( $(</proc/cmdline) )
cmdline_arg() {
    local name="$1" value="$2"
    for arg in "${cmdline[@]}"; do
        if [[ "${arg%%=*}" == "${name}" ]]; then
            value="${arg#*=}"
        fi
    done
    echo "${value}"
}

root=$(cmdline_arg root)
rootmkfs=$(cmdline_arg rootmkfs)
rootmkfstype=$(cmdline_arg rootmkfstype btrfs)
rootmkfsflags=$(cmdline_arg rootmkfsflags "-m single -l 32768 -n 32768 -L ROOT")

if [[ ${rootmkfs} == "" ]]; then
    exit 0
fi

if [[ ${root} == "" ]]; then
    echo "the kernel option 'root' must be specified along with rootmkfs."
    exit 1
fi

# check if the root exists
if [[ `blkid -o device ${root}` || `blkid -o device -t ${root}` ]]; then
    echo "root ${root} exists. rootmkfs will be ignored. continuing."
    exit 0
fi

# check if the selected device is a block device
if [[ ! -b ${rootmkfs} ]]; then
    echo "root device ${rootmkfs} is not found or is not a block device"
    exit 1
fi

#check if its already formatted
existingfs=`blkid ${rootmkfs} | sed -nr 's/^.*TYPE=\"(.*)\"$/\1/p'`
if [[ ${existingfs} != "" ]]; then
    echo "root device ${rootmkfs} already formatted with ${existingfs}. continuing."
    exit 0
fi

# check that its a supported fs
if [[ ${rootmkfstype} != "btrfs" && ${rootmkfstype} != "ext4" && ${rootmkfstype} != "xfs" ]]; then
    echo "unsupported rootmkfstype value $1" >&2
    exit 2
fi

# format the root
mkfs.${rootmkfstype} ${rootmkfsflags} ${rootmkfs}
