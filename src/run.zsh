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
print "Start Loop. i=$i, max=$max"
print "sourceroot=$sourceroot"
print "destroot=$destroot"

while (( i <= max ))
do
   local current_src_dir="${sourcedir[$i]}"
   local current_dest_dir="${destdir[$i]}"
   
   print "------------------------------------------------"
   print "Runde i=$i"
   print "sourcedir[$i] ist: '$current_src_dir'"
   print "destdir[$i]   ist: '$current_dest_dir'"

   local full_src_path="$sourceroot/$current_src_dir"
   local full_dest_path="$destroot/$timestamp/$current_dest_dir/"

   print "Voller Quellpfad: '$full_src_path'"
   print "Voller Zielpfad:  '$full_dest_path'"

   if [[ ! -d "$full_dest_path" ]]; then
       print "WARNUNG: Zielverzeichnis existiert nicht: $full_dest_path"
   fi

   for ext in $allext; 
   do
      local found_files=($full_src_path/*.${ext}(.N))
      
      print "  Extension .$ext -> Gefunden: ${#found_files} Dateien"

      if (( ${#found_files} > 0 )); then
          print "  Führe cp aus..."
          command cp -v -p "${found_files[@]}" "$full_dest_path"
      fi
   done
   
   (( i++ ))
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