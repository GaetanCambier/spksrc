#!/bin/bash

list="
88f6281 \
alpine \
armada370 \
armada375 \
armada38x \
armadaxp \
comcerto2k \
evansport \
monaco \
ppc853x \
qoriq \
x64 \
"

cd $1
make clean
for ARCH in ${list}
do
    make arch-${ARCH}-5.2 > compile-${ARCH}-5.2.log 2>&1 &
done

