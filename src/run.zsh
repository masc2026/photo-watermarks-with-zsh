#!/bin/zsh

zmodload zsh/zutil

MYDIR=${0:a:h}

setopt EXTENDED_GLOB
setopt NULL_GLOB
unsetopt NOMATCH

source "$MYDIR"/wm.zsh

zparseopts -D -E gifanim=animation webpanim=animation noelapsedtimewm=ignore nodatewm=ignore timewm=ignore nfcwm=ignore sortbyname=ignore tz::=usetz ext+:=useext

# set -ext default ".jpg"
if [[ ${#useext} -gt 1 ]]; then useext=($useext); else useext=(-ext jpg); fi;

for index in {2..${#useext}..2};do allext+=($useext[index]); done

# set timezone to adjust dateTimeOriginal to given timezone before ordering; default is +2
timezone=$( [[ ${#usetz[1]} -gt 3 ]] && print ${${usetz[1]}[4,$#${usetz[1]}]} || print 2 )

sourceroot="$MYDIR"/../"Example"
destroot="$MYDIR"/../"Example"

# Define Source and Destination
#destdir=("Blue" "Yellow" "Green" "Purple" "Red" "White")
destdir=("Photos")
#sourcedir=("Blau" "Gelb" "Grün" "Lila" "Rot" "Weiß")
sourcedir=("Photos")

specnametag="AL"
titletag="TI"
durtag="MS"
nfctag="NC"

timestamp=$(date +%s)

# Make Destination Directories
typeset -i i=1 max=${#sourcedir[*]}
while (( i <= max ))
do
   command mkdir -p "$destroot/$timestamp/${destdir[$i]}/Watermarked"
   i=i+1
done

# Copy from Source to Destination
i=1
while (( i <= max ))
do
   for ext in $allext; 
   do
      command cp -p "$sourceroot/${sourcedir[$i]}"/*.${ext}(.N) "$destroot/$timestamp/${destdir[$i]}/" > /dev/null 2>/dev/null
   done
   i=i+1
done

# Watermarking loop
typeset -i i=1 max=${#sourcedir[*]}
while (( i <= max ))
do
   workingdir="$destroot/$timestamp/${destdir[$i]}"
   watermark -specnametag $specnametag -titletag $titletag -durtag $durtag -nfctag $nfctag -tsdir "$workingdir" $animation $ignore -tz $timezone ${useext}
   i=i+1
done

return 0