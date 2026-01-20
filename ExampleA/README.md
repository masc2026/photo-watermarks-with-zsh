# Example A - Add Watermarks

Add watermarks.

## Result

<div align="center">

Original          |  Result
:-------------------------:|:-------------------------:
<img align="center" width="500" src="./Photos/ER6A2839.jpg"> | <img align="center" width="500" src="./img/file-000001_EA.webp">
<img align="center" width="500" src="./Photos/ER6A2861.jpg"> | <img align="center" width="500" src="./img/file-000002_EA.webp">
<img align="center" width="500" src="./Photos/ER6A2922.jpg"> | <img align="center" width="500" src="./img/file-000003_EA.webp">

</div>

## Instruction

Change to `photo-watermarks-with-zsh-main` directory

    cd <my projects>/photo-watermarks-with-zsh-main

Save the "Example" directory and copy the example files into a newly created "Example" directory:

    backup="$(date +%s)"; mkdir -p "Backup/$backup"; mv Example "Backup/$backup"; mkdir Example 
    cp -r ExampleA/Photos Example

Run the script to add watermarks:

    ./src/run.zsh

Find the path to the newly created files this way:

    print -l ./Example/[[:digit:]]#/Photos/Watermarked/(-om[1,1])