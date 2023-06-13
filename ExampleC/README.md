# Example C - Animated Gif and WebP

Create an animated `WebP` and `Gif` from a [photo series](./Photos/).

Photos have an additional keyword tags `MS` with numeric values indicating how long the photo is displayed in a animated `WebP` in `[ms]`. 

The `MS` tag and value is ignored for the animated `Gif`.

## Result

<div align="center">

Animated Gif         | Animated WebP   
:-------------------------:|:-------------------------:
<img align="center" width="600" src="https://www.mascapp.com/taxadb/img/animationExampleC.gif"> | <img align="center" width="600" src="https://www.mascapp.com/taxadb/img/animationExampleC.webp.png">
</div>

## Instruction

Change to `photo-watermarks-with-zsh-main` directory

    cd <my projects>/photo-watermarks-with-zsh-main

Save the "Example" directory and copy the example files into a newly created "Example" directory:

    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example 
    cp -r ExampleC/Photos Example

Run the script to create animated `WebP` and `Gif`:

    ./src/run.zsh -gifanim -webpanim -noelapsedtimewm -nodatewm