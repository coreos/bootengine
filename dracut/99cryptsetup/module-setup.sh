#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

depends() {
    echo fs-lib ignition
}

install() {
    mkdir -p "$initdir/boot"

    inst_simple "/usr/lib/coreos/coreos-cryptagent" \
        "/usr/bin/coreos-cryptagent"

    inst_simple "$moddir/coreos-cryptagent.service" \
        "$systemdsystemunitdir/coreos-cryptagent.service"

    inst_simple "$moddir/coreos-cryptagent.path" \
        "$systemdsystemunitdir/coreos-cryptagent.path"
    ln_r "${systemdsystemunitdir}/coreos-cryptagent.path" \
        "${systemdsystemunitdir}/initrd.target.wants/coreos-cryptagent.path"

    inst_simple "${moddir}/initrd-setup-boot.service" \
        "${systemdsystemunitdir}/initrd-setup-boot.service"
    ln_r "${systemdsystemunitdir}/initrd-setup-boot.service" \
        "${systemdsystemunitdir}/initrd.target.wants/initrd-setup-boot.service"

    inst_simple "$moddir/coreos-cryptagent-attach@.service" \
        "$systemdsystemunitdir/coreos-cryptagent-attach@.service"

    inst_rules \
        "$moddir/66-coreos-early-cryptsetup.rules" \
        "$moddir/99-xx-coreos-systemd-cryptsetup.rules"
}
