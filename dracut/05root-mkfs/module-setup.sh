#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

depends() {
	return 0
}

install() {
    dracut_install mkfs.btrfs mkfs.ext4 mkfs.xfs
    inst_simple "$moddir/diskless-btrfs" "$systemdutildir/root-mkfs"
}
