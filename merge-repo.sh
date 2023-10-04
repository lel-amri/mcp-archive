#!/bin/sh
cp archive-README.md workdir/README.md
git -C workdir add :/README.md
git -C workdir commit -m "Add README.md"
git remote add workdir ./workdir
git fetch -f workdir main:main
git remote remove workdir
