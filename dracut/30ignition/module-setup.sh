#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

depends() {
    echo qemu systemd
}

install() {
    inst_multiple \
        ignition \
        coreos-metadata \
        useradd \
        usermod \
        groupadd \
        systemd-detect-virt \
        mountpoint \
        mkfs.btrfs \
        mkfs.ext4 \
        mkfs.xfs \
        mkfs.vfat \
        mkswap \
        nvme

    inst_script "$udevdir/cloud_aws_ebs_nvme_id" \
        "/usr/lib/udev/cloud_aws_ebs_nvme_id"

    inst_script "$moddir/ignition-setup.sh" \
        "/usr/sbin/ignition-setup"

    inst_script "$moddir/retry-umount.sh" \
        "/usr/sbin/retry-umount"

    inst_simple "$moddir/ignition-generator" \
        "$systemdutildir/system-generators/ignition-generator"

    inst_simple "$moddir/ignition-disks.service" \
        "$systemdsystemunitdir/ignition-disks.service"

    inst_simple "$moddir/ignition-files.service" \
        "$systemdsystemunitdir/ignition-files.service"

    inst_simple "$moddir/ignition-quench.service" \
        "$systemdsystemunitdir/ignition-quench.service"

    inst_simple "$moddir/sysroot-boot.service" \
        "$systemdsystemunitdir/sysroot-boot.service"

    inst_simple "$moddir/coreos-digitalocean-network.service" \
        "$systemdsystemunitdir/coreos-digitalocean-network.service"

    inst_simple "$moddir/coreos-static-hostname.service" \
        "$systemdsystemunitdir/coreos-static-hostname.service"    

    inst_simple "$moddir/coreos-static-network.service" \
        "$systemdsystemunitdir/coreos-static-network.service"

    inst_rules \
        60-cdrom_id.rules \
        66-azure-storage.rules \
        90-cloud-storage.rules
}
