#!/bin/bash

arguments="$@"

input() {
    functionlist="\n1. fixme\n2. filecount\n3. filesizelist"

    echo -e "\e[1mWhich feature(s) would you like to execute? (Type 'help' for a list of commands, 'exit' to exit):\e[0m "
    read answer

    while [ "$answer" != "exit" ] ; do
        for ans in $answer ; do
            if [ $ans = "help" ] ; then
                echo -e "\e[100m\e[33m\e[4mList of Commands\e[1m\e[24m$functionlist\e[0m"
                while [ $answer != "return" ] ; do
                    echo -e "\e[1mEnter 'return' to return to command selection, or type the name of a function you would like further information on:\e[0m "
                    read answer
                    if [ $answer = "filesizelist" ] ; then
                        echo "filesizelist: "
                    elif [ $answer = "fixme" ] ; then
                        echo "fixme: "
                    elif [ $answer = "filecount" ] ; then
                        echo "filecount: "
                    elif [ $answer = "return" ] ; then
                        echo " "
                    else
                        echo "$answer is not a function"
                    fi
                done

            elif [ $ans = "fixme" ] ; then
                fixme
            elif [ $ans = "filecount" ] ; then
                filecount
            elif [ $ans = "filesizelist" ]  ; then
                filesizelist
            else
                echo "$ans"" is not a function"
            fi
        done
        echo -e "\e[1mWhich feature(s) would you like to execute? (Type 'help' for a list of commands, 'exit' to exit):\e[0m "
        read answer
    done
    echo "Goodbye!"
}

fixme(){

    searchterm='#FIXME'
    outputfolder="fixme.log"   
    files=$(rgrep -l "$searchterm")   
    newstring=""   

    for file in $files ; do

        if tail -1 "$file" | grep -q "$searchterm" && [ -z "$newstring" ] ; then    #If the last line of the file contains searchterm and the new string is empty
            newstring=$(printf "$file")                                             #Adds the filename to the first line of the new string 
        elif tail -1 "$file" | grep -q "$searchterm" ; then                         #If the newstring is not empty appends the filename to the next line
	    newstring=$(printf "$newstring \n$file")      
        fi    
    done

    echo "$newstring" > "$outputfolder"   
    cat "$outputfolder"

}

filecount(){

    echo "What extention would you like to search for?: "
    read search
    searchterm='.'$(echo "$search" | cut -d "." -f 2)                               #Takes the inputted string, removes a period if one is present, then adds a period,
    echo 'Counting '$searchterm'...'                                                #this ensures that the filetype is always in the form '.extention'
    count=$(ls -aRp | grep -v / | grep -E "$searchterm$" | wc -l)                   #Recurses through the directories listing everything, adds a / to the end of directories 
    echo "$count"                                                                   #then uses grep to remove everything with '/' proceeds to search for the extention at the end  
}                                                                                   #of all remaining files, then counts them


filesizelist(){

    ls -shS $(find -type f)                                                        #Finds all files in the directory and all subdirectories then, lists them all in human understood
}                                                                                  #sizing and sorts this list from greatest to smallest

if [ $# -gt 0 ] ; then
    for ans in $arguments ; do
        if [ $ans = "fixme" ] ; then
            fixme
        elif [ $ans = "filecount" ] ; then
            filecount
        elif [ $ans = "filesizelist" ]  ; then
            filesizelist
        else
            echo "$ans"" is not a function"
        fi
    done
else
    input
fi
