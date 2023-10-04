#!/bin/sh
git remote add workdir ./workdir
git fetch -f workdir main:main
git remote remove workdir
