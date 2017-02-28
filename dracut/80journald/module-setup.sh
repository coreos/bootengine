#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

depends() {
    echo systemd
}

install() {
    # Journal needs to forward to console so we may have some hope of #
    # understanding what goes wrong in ignition on cloud providers giving
    # read-only consoles to otherwise inaccessible instances.
    mkdir -p "$initdir/etc/systemd"
    {
        echo "[Journal]"
        echo "ForwardToConsole=yes"
    } >> "$initdir/etc/systemd/journald.conf"
}
