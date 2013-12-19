#!/bin/sh -e

root="gptprio:"
BOOTENGINE_ROOT_DIR="./mnt"

create_kernel_file() {
	create_root
	echo "THIS IS A KERNEL HONEST" > $BOOTENGINE_ROOT_DIR/boot/vmlinuz
}

create_empty_root() {
	/bin/rm -rf ${BOOTENGINE_ROOT_DIR}
	/bin/mkdir -p $BOOTENGINE_ROOT_DIR
}

create_root() {
	/bin/rm -rf ${BOOTENGINE_ROOT_DIR}
	/bin/mkdir -p $BOOTENGINE_ROOT_DIR/boot
	/bin/mkdir -p $BOOTENGINE_ROOT_DIR/dev
	/bin/mkdir -p $BOOTENGINE_ROOT_DIR/proc
	/bin/mkdir -p $BOOTENGINE_ROOT_DIR/sys
}

cleanup_root() {
	if [ -e ${BOOTENGINE_ROOT_DIR}/.failed ]; then
		cat ${BOOTENGINE_ROOT_DIR}/.failed
		/bin/rm -rf ${BOOTENGINE_ROOT_DIR}
		echo FAILED
		exit 1
	fi
	/bin/rm -rf ${BOOTENGINE_ROOT_DIR}
}

fail() {
	echo "FAIL: $@"
	echo "FAIL: $@" >> ${BOOTENGINE_ROOT_DIR}/.failed
}

fail_if() {
	if "$@"; then
		fail "$@"
	fi
}

assert() {
	if ! "$@"; then
		fail assert "$@"
	fi
}
