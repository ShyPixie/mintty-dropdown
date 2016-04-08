#!/bin/sh

function pack {
    zip ${1}_Windows_${2}bits.zip ${1}.exe ${1}.ini || exit 1
}

function mk {
    make clean || exit 1
    make PROCESSOR_ARCHITECTURE=${1} || exit 1
}

rm -f *.zip
mk x86
pack mintty-dropdown 32
mk amd64
pack mintty-dropdown 64
