# Example C - Animated Gif and WebP

Photos with additional keyword tag `MS` and a number indicating in [ms] how long the photo is displayed in a animated `WebP`. This value is ignored for the animated `Gif`.

Add TI or AL watermarks and build animated `WebP` and `Gif`.

## Instructions

Change to `photo-watermarks-with-zsh-main` directory

    cd <my projects>/photo-watermarks-with-zsh-main

Create animated `WebP` and `Gif` from the [photo series](./Photos/)

    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example 
    cp -r ExampleC/Photos Example
    ./src/run.zsh -gifanim -webpanim -noelapsedtimewm -nodatewm

Output:

        1 image files updated
    ...
    Saved file <my projects>/photo-watermarks-with-zsh-main/src/../Example/<timestamp>/Photos/Watermarked/animation.webp (2255176 bytes)

The created photos and the `animation.webp` and `animation.gif` are here: `<my projects>/src/../Example/<timestamp>/Photos/Watermarked`. 

Display the animated `Gif` and `WebP` in a browser and see that the time how long the images are displayed in `animation.webp` varies, but is constant in `animation.gif`.

<div align="center">

Animated Gif         | Animated WebP   
:-------------------------:|:-------------------------:
<img align="center" width="600" src="https://www.mascapp.com/taxadb/img/animationExampleC.gif"> | <img align="center" width="600" src="https://www.mascapp.com/taxadb/img/animationExampleC.webp.png">
</div>
<br />