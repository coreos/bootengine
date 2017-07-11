#!/bin/bash

# This is a dummy module that satisfies other modules' dependencies on
# "network" while preserving the existing network behavior.

# called by dracut
depends() {
    echo coreos-network
}
