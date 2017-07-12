#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

depends() {
    echo coreos-network iscsi
}

install() {
    inst_simple "$systemdsystemunitdir/iscsid-initiatorname.service"

    inst_simple "$moddir/iscsi-generator" \
        "$systemdutildir/system-generators/iscsi-generator"

    inst_simple "$moddir/iscsi-networkd.conf" \
        "$systemdsystemunitdir/iscsid.service.d/networkd.conf"

    inst_simple "$moddir/initiatorname-order.conf" \
        "$systemdsystemunitdir/iscsid-initiatorname.service.d/order.conf"

    # Drop symlinks enabling iscsi by default.
    rm -f -- "$initdir$systemdsystemunitdir"/*.wants/*iscsi*.*
}
