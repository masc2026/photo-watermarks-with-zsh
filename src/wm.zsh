#!/bin/zsh

zmodload zsh/zutil

MYDIR=${0:a:h}

setopt EXTENDED_GLOB
setopt NULL_GLOB
unsetopt NOMATCH

watermark ()
{
   zparseopts -D -E -A opts specnametag::=opts titletag::=opts nfctag::=opts durtag::=opts tsdir:=opts gifanim=animation webpanim=animation noelapsedtimewm=ignore nodatewm=ignore timewm=ignore nfcwm=ignore sortbyname=ignore tz:=usetz ext+:=useext
   
   local assetsdir="$MYDIR"/../"assets"
   local tsdir=$opts[-tsdir]
   local specnametag=$opts[-specnametag]
   local durframetag=$opts[-durtag]
   local titletag=$opts[-titletag]
   local nfctag=$opts[-nfctag]
   local creategifanim=$( [[ $animation[(Ie)-gifanim] -gt 0 ]] && print true || print false )
   local createwebpanim=$( [[ $animation[(Ie)-webpanim] -gt 0 ]] && print true || print false )
   local noelapsedtimewm=$( [[ $ignore[(Ie)-noelapsedtimewm] -gt 0 ]] && print true || print false )
   local nodatewm=$( [[ $ignore[(Ie)-nodatewm] -gt 0 ]] && print true || print false )
   local timewm=$( [[ $ignore[(Ie)-timewm] -gt 0 ]] && print true || print false )
   local nfcwm=$( [[ $ignore[(Ie)-nfcwm] -gt 0 ]] && print true || print false )
   local sortbydate=$( [[ $ignore[(Ie)-sortbyname] -gt 0 ]] && print false || print true )
   local timezone=$usetz[2]

   # set standard duration in [ms] for webp animation frame if no $durframetag tag set
   local stdwebpframedur=500
   # set duration in 10 [ms] for gif animation frame
   local gifframedur=50

   local webpframes=( )
   local fileInfo=()

   cd $tsdir

   exiftool -P '-datetimeoriginal<filemodifydate' -r -if 'not defined $datetimeoriginal or $datetimeoriginal !~ /\d/' ${useext[@]} . > /dev/null 2>/dev/null
   exiftool -P '-offsetTimeOriginal=+02:00' -r -if 'not defined $offsetTimeOriginal or $offsetTimeOriginal !~ /\d/' ${useext[@]} . > /dev/null 2>/dev/null

   # echo $fileInfo[1] out: 2023:05:22 09:26:07 +01:00 ER6A3 408 .jpg
   fileInfo=("${(@f)$(exiftool -p '$dateTimeOriginal $offsetTimeOriginal $fileName' -q -q -f ${useext[@]} *(.on))}")

   # filter out where time info is missing
   fileInfo=("${(@f)$(print -l ${fileInfo/#%(#b)(^[[:digit:]]#:[[:digit:]]#:[[:digit:]]#\ [[:digit:]]#:[[:digit:]]#:[[:digit:]]#\ [+|-|''][[:digit:]]#:[[:digit:]]#\ *.*)/$match[0]})}")
   # adjust time according to $timezone value and order by adjusted date time original
   # in: 2021:05:22 09:51:15 +03:00 IMG_0344.jpg
   # with timezone=3 - out: 2021 05 22 09 51 15 IMG_0344.jpg
   # with timezone=-4 - out: 2021 05 22 02 51 15 IMG_0344.jpg

   if [[ $sortbydate = true ]];
   then
      fileInfo=("${(@f)$(print -l ${fileInfo/#(#b)([[:digit:]]#:[[:digit:]]#:[[:digit:]]#\ [[:digit:]]#:[[:digit:]]#:[[:digit:]]#)\ ([+|-|''])([[:digit:]]#):[[:digit:]]#\ (*.*)/$([[ $match[2] == '+' ]] && offset=$(( $timezone-match[3] )) || offset=$(( $timezone+match[3] )); (( offset > 0 || offset == 0 )) && sign="+" || sign="" ; newdate=$([[ $(uname) = "Darwin" ]] && print $(date -j -v${sign}${offset}H -f "%Y:%2m:%2d %2H:%2M:%2S" "$match[1]" "+%Y:%m:%d %H:%M:%S") || print $(date -u --date=${match[1]/#(#b)([[:digit:]]#):([[:digit:]]#):([[:digit:]]#)\ ([[:digit:]]#:[[:digit:]]#:[[:digit:]]#)/$match[1]-$match[2]-$match[3] $match[4]}' +0000 '$sign$offset' hours' "+%Y:%m:%d %H:%M:%S")); print -f "%s %s\n" $newdate $match[4] )} | command tr : ' ' | command sort -k2 -k3 -k4 -k5 -k6 -k7)}")
   else
      fileInfo=("${(@f)$(print -l ${fileInfo/#(#b)([[:digit:]]#:[[:digit:]]#:[[:digit:]]#\ [[:digit:]]#:[[:digit:]]#:[[:digit:]]#)\ ([+|-|''])([[:digit:]]#):[[:digit:]]#\ (*.*)/$([[ $match[2] == '+' ]] && offset=$(( $timezone-match[3] )) || offset=$(( $timezone+match[3] )); (( offset > 0 || offset == 0 )) && sign="+" || sign="" ; newdate=$([[ $(uname) = "Darwin" ]] && print $(date -j -v${sign}${offset}H -f "%Y:%2m:%2d %2H:%2M:%2S" "$match[1]" "+%Y:%m:%d %H:%M:%S") || print $(date -u --date=${match[1]/#(#b)([[:digit:]]#):([[:digit:]]#):([[:digit:]]#)\ ([[:digit:]]#:[[:digit:]]#:[[:digit:]]#)/$match[1]-$match[2]-$match[3] $match[4]}' +0000 '$sign$offset' hours' "+%Y:%m:%d %H:%M:%S")); print -f "%s %s\n" $newdate $match[4] )} | command tr : ' ' )}")
   fi

   # echo $firstLastOfSeries[1] out: 2023 05 22 09 51 15 ER6A3388.jpg
   # echo $firstLastOfSeries[2] out: 2023 05 22 12 22 03 ER6A3498.jpg
   local firstLastOfSeries=("${(@f)$(print -l $fileInfo | command sed '1p;$!d')}")
   # echo $start out: 2023-05-22 09:51:15
   local start=${firstLastOfSeries[1]/#(#b)([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#)*/${match[1]}-${match[2]}-${match[3]} ${match[4]}:${match[5]}:${match[6]}}
   
   # echo $end out: 2023-05-22 12:22:03
   # local end=${firstLastOfSeries[2]/#(#b)([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#)*/${match[1]}-${match[2]}-${match[3]} ${match[4]}:${match[5]}:${match[6]}}

   local idx=0;

   for fileInfoNxt in $fileInfo;
   do
      # fileName e.g. "Foto-00121.jpg"
      local fileName=${fileInfoNxt/#(#b)([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) ([[:digit:]]#) (*.*)*/${match[7]}}

      # fileDateTime e.g. "2023-05-03 12:09:03"
      local fileDateTime="$match[1]-$match[2]-$match[3] $match[4]:$match[5]:$match[6]"
      # Get Exif data:
      local exifData=$( exiftool -p '$imagewidth # $imageheight # $city # $state # $country # $gpsaltitude # $countrycode' -q -f "$fileName" )
      exifDataA=(${(@s:#:)exifData}) 

      # JPEG Tag 'Image Width' see https://exiftool.org/TagNames/JPEG.html#AVI1
      local imageWidth=$exifDataA[1]
      # JPEG Tag 'Image Height' see https://exiftool.org/TagNames/JPEG.html#AVI1
      local imageHeight=$exifDataA[2]
      # XMP photoshop Tag 'Date Time Original' see https://exiftool.org/TagNames/XMP.html
      local originDate="$match[3].$match[2].$match[1]"
      local originTime="$match[4]:$match[5]:$match[6]"
      # XMP Tags 'City', 'State', 'Country', 'GPS Altitude', 'Country Code' see https://exiftool.org/TagNames/XMP.html
      local city=$exifDataA[3]
      local state=$exifDataA[4]
      local country=$exifDataA[5]
      local altitude=$exifDataA[6]
      local countryCode=$exifDataA[7]
      # Liest Keywords (IPTC) aus, falls leer, wird Subject (XMP) genommen
      alltags=$(exiftool -s3 -m -Best -Keywords -Subject "$fileName" | head -n 1)
      # Search pattern is $specnametag:nameL
      local nameL=()
      : ${alltags//(#m)${specnametag}:[^,]#/${nameL[1+$#nameL]::=$MATCH[$#specnametag+2,$#MATCH]}}
      # Search pattern is $titletag:titleL
      local titleL=()
      : ${alltags//(#m)${titletag}:[^,]#/${titleL[1+$#titleL]::=$MATCH[$#titletag+2,$#MATCH]}}      
      # Search pattern is $nfctag:nfcL
      local nfcL=()
      : ${alltags//(#m)${nfctag}:[^,]#/${nfcL[1+$#nfcL]::=$MATCH[$#nfctag+2,$#MATCH]}}
      # Search pattern is $durframetag:durL
      local durL=()
      : ${alltags//(#m)${durframetag}:[0123456789]#/${durL[1+$#durL]::=${MATCH[$#durframetag+2,$#MATCH]}}}

      [[ $#durL = 0 ]] && durL=($stdwebpframedur)

      # magick $fileName -resize 614x $fileName
      # magick ~/iPhoneSE3.png $fileName -geometry +129+364 -composite $fileName

      local duridx=0;

      for durNxt in $durL;
      do
         (( duridx=duridx+1 ))
         (( idx=idx+1 ))

         [[ $#durNxt = 0 ]] && durNxt=($stdwebpframedur)

         # Build the comment string ... 
         local comment="{\"City\":\"$city\",\"State\":\"$state\",\"Country\":\"$countryCode\",\"Altitude\":\"$altitude\",\"Date\":\"$originDate\"}"
         # ... and add it as JPEG Tag 'COMMENT' and remove all other EXIF data
         exiftool -COMMENT="$comment" -overwrite_original $fileName

         local wmDate=

         if [[ $timewm = false ]];
         then
            wmDate=$originDate
         else
            wmDate="$originDate  $originTime"
         fi

         if [[ $createwebpanim = true ]];
         then
            magick $fileName -background white -alpha remove -alpha off $fileName
         fi

         #continue

         # Create Watermark Images
         # Next Frame Command for Screencast
         if [[ $nfcwm = true && -n "$nfcL[$duridx]" ]]; then
            magick -size 220x80 xc:transparent -fill "rgba(0, 0, 0, 0.3)" -draw "roundrectangle 0,0,220,80,15,15" -fill none -gravity center -fill white -font "$assetsdir/OpenSans-Regular.ttf" -pointsize 50 -draw "text 0,0 '$nfcL[$duridx]'" nfcStamp.png
            composite -dissolve 100% -gravity center -geometry +00+05 -density 72 nfcStamp.png $fileName "wm_$fileName"
         else
            command cp $fileName "wm_$fileName"
         fi

         if [[ -n "$nameL[$duridx]" ]]; then
            # specnametag Keyword was found:
            wmName=$nameL[$duridx]
            # Create nameTitleStamp.png temp file
            magick -background none -fill white -font "$assetsdir/Tinos-Italic.ttf" -pointsize 25 label:"$wmName" -trim \( +clone -background black  -shadow 100x3+0+0 \) +swap -background none -layers merge +repage  nameTitleStamp.png
            composite -dissolve 100% -gravity north -geometry +00+05 -density 72 nameTitleStamp.png "wm_$fileName" "wm_$fileName"
         else
            # use title as watermark if name not found
            if [[ -n "$titleL[$duridx]" ]]; then
               # titletag Keyword was found:
               wmTitle=$titleL[$duridx]
               # Create nameTitleStamp.png temp file
               magick -background none -fill white -font "$assetsdir/Roboto-Regular.ttf" -pointsize 25 label:"$wmTitle" -trim \( +clone -background black  -shadow 100x3+0+0 \) +swap -background none -layers merge +repage  nameTitleStamp.png
               composite -dissolve 100% -gravity north -geometry +00+10 -density 72 nameTitleStamp.png "wm_$fileName" "wm_$fileName"
            fi
         fi

         if [[ $noelapsedtimewm = false ]];
         then
            # Create elapsedTimeStamp.png temp file
            local timediff=$(( $([[ $(command uname) = "Darwin" ]] && print $(command date -j -f "%Y-%2m-%2d %2H:%2M:%2S" "$fileDateTime" +%s) || print $(command date -u --date=$fileDateTime +%s))-$([[ $(command uname) = "Darwin" ]] && print $(date -j -f "%Y-%2m-%2d %2H:%2M:%2S" "$start" +%s) || print $(command date -u --date=$start +%s)) ))
            local days=$(( timediff / (60 * 60 * 24) ))
            local hms=$(( timediff % (60 * 60 * 24) ))
            local hours=$(( hms / (60 * 60) ))
            local minutes=$(( ((hms % (60 * 60))  / (60)) ))
            local seconds=$(( hms % 60 ))
            if [[ ( $days -lt 1 ) ]];
            then
               local elapsedTime=$( print -f "%02d:%02d:%02d" $hours $minutes $seconds )
            else
               if [[ ( $days = 1 ) ]];
               then
                  elapsedTime=$( print -n $days day' '; print -f "%02d:%02d:%02d" $hours $minutes $seconds )
               else
                  elapsedTime=$( print -n $days days' '; print -f "%02d:%02d:%02d" $hours $minutes $seconds )
               fi
            fi
            local wmElapsedTime=$elapsedTime

            # Create elapsedTimeStamp.png temp file
            magick -background none -fill gray -font "$assetsdir/Roboto-Regular.ttf" -pointsize 30 label:"$wmElapsedTime" -trim \( +clone -background black  -shadow 50x3+0+0 \) +swap -background none -layers merge +repage  elapsedTimeStamp.png
            composite -dissolve 50% -gravity south-east -geometry +05+05 -density 72 elapsedTimeStamp.png "wm_$fileName" "wm_$fileName"
         fi

         if [[ $nodatewm = false ]];
         then
            # Create dateStamp.png temp file
            magick -background none -fill gray -font "$assetsdir/Roboto-Regular.ttf" -pointsize 30 label:"$wmDate" -trim \( +clone -background black  -shadow 50x3+0+0 \) +swap -background none -layers merge +repage  dateStamp.png
            
            # Allign dateStamp.png at the top edge of elapsedTimeStamp.png
            local offset=$([[ -f dateStamp.png && -f elapsedTimeStamp.png ]] && print $(( 5 + $(exiftool -s3 -ImageHeight elapsedTimeStamp.png) - $(exiftool -s3 -ImageHeight dateStamp.png) ))  || print 5)
            offset=$((( offset<0 )) && print "$offset" || print "+$offset")

            composite -dissolve 50% -gravity south-west -geometry +05$offset -density 72 dateStamp.png "wm_$fileName" "wm_$fileName"
         fi
         
         local origfilesext=$fileName:t:e
         local newfilename=$(print -f "file-%06d.$origfilesext" $idx)

         # Copy wm_filename.<origfilesext> as $newfilename.<origfilesext>
         print "New photo created from original $fileName with watermark: $tsdir/Watermarked/$newfilename"
         command cp "wm_"$fileName Watermarked/"$newfilename"

         # Create webp image (optional)
         if [[ $createwebpanim = true ]];
         then
            local newwebpfilename=$(print -f "file-%06d.webp" $idx)
            cwebp -q 80 "Watermarked/$newfilename" -o "Watermarked/$newwebpfilename" 2>> /dev/null
            webpframes+=( -frame "$tsdir/Watermarked/$newwebpfilename" +$durNxt+0+0+0+b )
         fi

         # Delete wm_filename.<extension>
         command rm "wm_"$fileName 2> /dev/null
         # Delete stamp png files
         command rm nfcStamp.png 2> /dev/null
         command rm nameTitleStamp.png 2> /dev/null
         command rm dateStamp.png 2> /dev/null
         command rm elapsedTimeStamp.png 2> /dev/null
      done
   done

   if [[ $createwebpanim = true ]];
   then
      webpmux "${webpframes[@]}" -o "$tsdir/Watermarked"/animation.webp
#   # frames preview
#   integer columns=5
#   local thumb_size="400x"
#   local -a all_frames
#   all_frames=("$tsdir/Watermarked"/file-*.(webp)(.n))
#   if (( ${#all_frames} > 0 )); then
#      local -a grid_frames
#      grid_frames=("${all_frames[@]:0:10}") 
#      magick montage "${grid_frames[@]}" \
#         -tile "${columns}x" \
#         -geometry "${thumb_size}>+3+3" \
#         -background white \
#         -quality 80 \
#         -define webp:lossless=false \
#         "$tsdir/Watermarked/frames.webp"
#   fi
   fi
   if [[ $creategifanim = true ]];
   then
      magick -delay $gifframedur -loop 0 "$tsdir/Watermarked"/*.* "$tsdir/Watermarked"/animation.gif
   fi
 


}