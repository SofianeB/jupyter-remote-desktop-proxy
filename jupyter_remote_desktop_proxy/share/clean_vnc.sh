#!/bin/bash

DIRECTORY='/tmp/.X11-unix/'



# Signalhandler
trap clean_vncservers 0 1 2 3 6 9 11 15 16 20

function clean_vncservers() {
    
    if [ -d $DIRECTORY ]; then
       
       while IFS= read socketfile; do
   
       display=$(echo ${socketfile} | sed -e 's!.*X11-unix/X\([0-9]\+\)!\1!')
       /opt/TurboVNC/bin/vncserver -kill :${display}
   
       done < <(find /tmp/.X11-unix/ -type s -a -user ${USER} -a -regex "/tmp/.X11-unix/X[0-9]*" | sort)
    fi

}
