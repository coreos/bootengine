#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

depends() {
    echo fs-lib
}

install() {
    dracut_install awk
    dracut_install /usr/bin/cgpt
    dracut_install /usr/sbin/kexec
    dracut_install /usr/bin/old_bins/cgpt
    inst_hook cmdline 80 "$moddir/parse-usr-gptprio.sh"
    inst_hook pre-mount 99 "$moddir/usr-gptprio-lib.sh"
    inst_hook pre-pivot 95 "$moddir/pre-pivot-usr-gptprio.sh"
}
