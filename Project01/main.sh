#!/bin/bash

fixme(){

    searchterm='#FIXME'
    outputfolder="fixme.log"   
    files=$(rgrep -l "$searchterm")   
    newstring=""   

    for file in $files ; do   
        if tail -1 "$file" | grep -q "$searchterm" && [ -z "$newstring" ] ; then      
            newstring=$(printf "$file")   
        elif tail -1 "$file" | grep -q "$searchterm" ; then     
	    newstring=$(printf "$newstring \n$file")      
        fi    
    done

    echo "$newstring" > "$outputfolder"   
    cat "$outputfolder"

}

filecount(){

    echo "What extention would you like to search for?: "
    read search
    searchterm='.'$(echo "$search" | cut -d "." -f 2) 
    echo 'Counting '$searchterm'...'
    count=$(ls -Rp | grep -v / | grep "$searchterm" | wc -l)
    echo "$count"

}

filesizelist(){
    ls -shS $(find -type f)

}