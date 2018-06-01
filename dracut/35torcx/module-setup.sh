#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

depends() {
    echo ignition
}

install() {
    inst_simple "$moddir/torcx-profile-populate-generator" \
        "$systemdutildir/system-generators/torcx-profile-populate-generator"

    inst_simple "${moddir}/torcx-profile-populate.service" \
        "${systemdsystemunitdir}/torcx-profile-populate.service"
}
