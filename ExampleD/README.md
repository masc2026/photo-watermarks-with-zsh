# Example D -  Set the time zone

Photos with different timezone settings, some are +1 others +3, are set to timezone +3 and an animated `WebP` is created. Add TI or AL and capture time watermarks.

## Instructions

Change to `photo-watermarks-with-zsh-main` directory

    cd <my projects>/photo-watermarks-with-zsh-main

Create animated `WebP` with timezone set to +3 from the [photo series](./Photos/)

    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example 
    cp -r ExampleD/Photos Example
    ./src/run.zsh -tz 3 -webpanim -withtimewm

Output:

        1 image files updated
    ...
    Saved file <my projects>/photo-watermarks-with-zsh-main/src/../Example/<timestamp>/Photos/Watermarked/animation.webp (1430930 bytes)

<div align="center">

<img align="center" width="700" src="https://www.mascapp.com/taxadb/img/animationExampleDTZp3.webp.png">

</div>

<br/>

Create animated `WebP` with timezone set to -4 from the [photo series](./Photos/)


    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example 
    cp -r ExampleD/Photos Example
    ./src/run.zsh -tz -4 -webpanim -withtimewm

<div align="center">

<img align="center" width="700" src="https://www.mascapp.com/taxadb/img/animationExampleDTZm4.webp.png">

</div>