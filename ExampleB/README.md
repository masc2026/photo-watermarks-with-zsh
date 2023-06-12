# Example B - Photo series with different time zones

Add watermarks and build an animated WebP.

The photos are quite small, so it makes sense to change the font size of the text used as a watermark.

## Instructions

Change to `photo-watermarks-with-zsh-main` directory

    cd <my projects>/photo-watermarks-with-zsh-main

Create an animated `WebP` from the [photo series B](./Photos/)

    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example 
    cp -r ExampleB/Photos Example
    ./src/run.zsh -webpanim

Output:

        1 image files updated
    ...
    Saved file <my projects>/photo-watermarks-with-zsh-main/src/../Example/<timestamp>/Photos/Watermarked/animation.webp (661560 bytes)

Find the newly created photos and the `animation.webp` here: `<my projects>/src/../Example/<timestamp>/Photos/Watermarked`.

<div align="center">

<img align="center" width="400" src="https://www.mascapp.com/taxadb/img/animationExampleB.webp.png">

</div>
<br/>