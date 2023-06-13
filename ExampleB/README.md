# Example B - Photo series with different time zones

Add watermarks and build an animated WebP from a [photo series](./Photos/).

Since the photos are quite small, it makes sense to change the font size: Search for `-pointsize` in the script `wm.zsh` and change it to a smaller value accordingly.

## Result

<div align="center">

<img align="center" width="400" src="https://www.mascapp.com/taxadb/img/animationExampleB.webp.png">

</div>

## Instruction

Change to `photo-watermarks-with-zsh-main` directory

    cd <my projects>/photo-watermarks-with-zsh-main

Save the "Example" directory and copy the example files into a newly created "Example" directory:

    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example 
    cp -r ExampleB/Photos Example

Run the script to create animated `WebP`:

    ./src/run.zsh -webpanim