#!/bin/bash

# get sink names:
# pacmd list-sinks | grep 'name:' | sed -n -e 's/.*<\(.*\)>$/\1/p'
# get active sink:
# pacmd list-sinks | grep -A 1 '\*' | sed -n -e '2s/.*<\(.*\)>$/\1/p'
all_sink_names=(`pacmd list-sinks | grep 'name:' | sed -n -e 's/.*<\(.*\)>$/\1/p'`)
active_sink=`pacmd list-sinks | grep -A 1 '\*' | sed -n -e '2s/.*<\(.*\)>$/\1/p'`
sink_count=${#all_sink_names[@]}

for (( i=0; i<$sink_count; i++ )); do
    if [ "$active_sink" == "${all_sink_names[$i]}" ]; then
        if [ $i == $(($sink_count-1)) ]; then
            new_sink=${all_sink_names[0]}
        else
            new_sink=${all_sink_names[$(($i+1))]}
        fi
        if [ $# != 0 ]; then
            pacmd set-default-sink $new_sink
            active_sink=$new_sink
        fi
        break;
    fi
done;
echo $active_sink
