# Example A - Add Watermarks

Add watermarks.

## Result

<div align="center">

Original          |  Result
:-------------------------:|:-------------------------:
<img align="center" width="500" src="./Photos/ER6A2839.jpg"> | <img align="center" width="500" src="../img/file-000001_EA.jpg">
<img align="center" width="500" src="./Photos/ER6A2861.jpg"> | <img align="center" width="500" src="../img/file-000002_EA.jpg">
<img align="center" width="500" src="./Photos/ER6A2922.jpg"> | <img align="center" width="500" src="../img/file-000003_EA.jpg">

</div>

## Instructions

Change to `photo-watermarks-with-zsh-main` directory

    cd <my projects>/photo-watermarks-with-zsh-main

Create an animated `WebP` from the [photo series](./Photos/)

    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example
    cp -r ExampleA/Photos Example
    ./src/run.zsh

Output:

        1 image files updated
    ...
    New photo created from original ER6A2922.jpg with watermark: <my projects>/src/../Example/<timestamp>/Photos/Watermarked/file-000003.jpg

Find the newly created photos here: `<my projects>/src/../Example/<timestamp>/Photos/Watermarked`.
<br/>