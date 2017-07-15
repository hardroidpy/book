pattern="*.lyx"

if [ ! -z "$1" ]; then
    pattern=$1
fi 

./node_modules/.bin/fsmonitor +$pattern make tex latex
