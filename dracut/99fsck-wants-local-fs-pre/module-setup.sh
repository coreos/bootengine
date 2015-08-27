#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

install() {
    # Want local-fs-pre.target by the fscks to ensure they get ordered
    # after it.
    #
    # Without this we may begin fscks before local-fs-pre.target becomes
    # activated, rendering the already present "After local-fs-pre.target"
    # ineffective, which can result in fscks occurring simultaneous to
    # ignition-disks.

    mkdir -p "${initdir}/${systemdsystemunitdir}/systemd-fsck@.service.wants"
    ln_r "${systemdsystemunitdir}/local-fs-pre.target" \
        "${systemdsystemunitdir}/systemd-fsck@.service.wants/local-fs-pre.target"
}
