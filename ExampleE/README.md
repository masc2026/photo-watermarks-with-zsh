# Example E -  Creating a screencast from a screenshot series

Creating a screencast from a [screenshot series](./Photos/).

## Result

<div align="center">

<img align="center" width="700" src="https://www.mascapp.com/taxadb/img/animationExampleESmall.webp.png">

</div>

## Instructions

Change to `photo-watermarks-with-zsh-main` directory

    cd <my projects>/photo-watermarks-with-zsh-main

Create animated `WebP` ("Screencast") from the [screenshot series](/Photos/). Adding Exif keywords for the title, the duration of each frame and the keystroke:

    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example
    cp -r ExampleE/Photos Example
    exiftool -P -Keywords="TI:Start the script,NC:CMD-v,MS:1000" -overwrite_original ./Example/Photos/img_1686487311.png
    exiftool -P -Keywords="TI:View after loading the project list,NC:,MS:500" -overwrite_original ./Example/Photos/img_1686487319.png
    exiftool -P -Keywords="TI:Next page,NC:RIGHT,MS:500" -overwrite_original ./Example/Photos/img_1686487328.png
    exiftool -P -Keywords="TI:Previous page,NC:LEFT,MS:500" -overwrite_original ./Example/Photos/img_1686487333.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:200" -overwrite_original ./Example/Photos/img_1686487338.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:200" -overwrite_original ./Example/Photos/img_1686487343.png
    exiftool -P -Keywords="TI:Change visibility,NC:s,MS:500" -overwrite_original ./Example/Photos/img_1686487347.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:500" -overwrite_original ./Example/Photos/img_1686487352.png
    exiftool -P -Keywords="TI:Change visibility,NC:s,MS:500" -overwrite_original ./Example/Photos/img_1686487356.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:200" -overwrite_original ./Example/Photos/img_1686487359.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:200" -overwrite_original ./Example/Photos/img_1686487363.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:200" -overwrite_original ./Example/Photos/img_1686487368.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:200" -overwrite_original ./Example/Photos/img_1686487370.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:200" -overwrite_original ./Example/Photos/img_1686487375.png
    exiftool -P -Keywords="TI:Change visibility,NC:s,MS:500" -overwrite_original ./Example/Photos/img_1686487379.png
    exiftool -P -Keywords="TI:Browsing projects,NC:DOWN,MS:500" -overwrite_original ./Example/Photos/img_1686487381.png
    exiftool -P -Keywords="TI:Change visibility,NC:s,MS:500" -overwrite_original ./Example/Photos/img_1686487384.png
    exiftool -P -Keywords="TI:Update on GitLab,NC:u,MS:500" -overwrite_original ./Example/Photos/img_1686487392.png
    exiftool -P -Keywords="TI:Updating,NC:,MS:200" -overwrite_original ./Example/Photos/img_1686487393.png
    exiftool -P -Keywords="TI:Updating,NC:,MS:200" -overwrite_original ./Example/Photos/img_1686487395.png
    exiftool -P -Keywords="TI:Updating,NC:,MS:200" -overwrite_original ./Example/Photos/img_1686487397.png
    exiftool -P -Keywords="TI:Update done,NC:,MS:500" -overwrite_original ./Example/Photos/img_1686487399.png
    ./src/run.zsh -ext png -noelapsedtimewm -nodatewm -webpanim -nfcwm

Output:

        1 image files updated
    ...
    Saved file <my projects>/photo-watermarks-with-zsh/src/../Example/<timestamp>/Photos/Watermarked/animation.webp (2184766 bytes)