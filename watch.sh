#!/bin/bash
pattern="*.lyx"

ext=$1
target="tex latex"
if [ "-s" == "$1" ]; then
    target="tex-slide latex-slide";
    ext=$2;
fi

if [ ! -z "$ext" ]; then
    pattern=$ext;
fi 

./node_modules/.bin/fsmonitor +$pattern make $target
