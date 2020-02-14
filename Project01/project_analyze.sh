#!/bin/bash


heirarchy="$( echo "$0" | rev | cut -d "/" -f 2- | rev)"
arguments="$@"

input() {
    functionlist="\n1. fixme\n2. filecount\n3. filesizelist"

    echo -e "\e[1mWhich feature(s) would you like to execute? (Type 'help' for a list of commands, 'exit' to exit):\e[0m "
    read answer

    while [ "$answer" != "exit" ] ; do
        for ans in $answer ; do
            if [ "$ans" = "help" ] ; then
                echo -e "\e[100m\e[33m\e[4mList of Commands\e[1m\e[24m$functionlist\e[0m"
                while [ "$answer" != "return" ] ; do
                    echo -e "\e[1mEnter 'return' to return to command selection, or type the name of a function you would like further information on:\e[0m "
                    read answer
                    for ans in $answer ; do
                        if [ $ans = "filesizelist" ] ; then
                            echo -e "\e[1m\e[100m$(grep '<filesizelist>' "$heirarchy/README.md")\e[0m"
                        elif [ $ans = "fixme" ] ; then
                            echo -e "\e[1m\e[100m$(grep '<fixme>' "$heirarchy/README.md")\e[0m"
                        elif [ $ans = "filecount" ] ; then
                            echo -e "\e[1m\e[100m$(grep '<filecount>' "$heirarchy/README.md")\e[0m"
                        elif [ $ans = "return" ] ; then
                            answer="return"
                        else
                            echo "$ans is not a function"
                        fi
                    done
                done

            elif [ $ans = "fixme" ] ; then
                fixme
            elif [ $ans = "filecount" ] ; then
                filecount
            elif [ $ans = "filesizelist" ]  ; then
                filesizelist
            elif [ $ans = "backupDelRest" ] ; then
                backupDelRest
            elif [ $ans = "switchEx" ] ; then
                switchEx
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

    searchterm='FIXME'
    outputfile="$heirarchy/fixme.log"
    if [ -e "$outputfile" ] ; then
        rm "$outputfile"
    fi
    touch "$outputfile"
    find . -wholename "*/.git" -prune -o -type f -print0 | while IFS= read -d '' file
    do
        if tail -1 "$file" | grep -q "$searchterm" ; then
            echo "$file" >> "$outputfile"
        fi
    done
    unset IFS  
    cat "$outputfile"

}

filecount(){

    echo -e "\e[1mWhat file type would you like to count?:\e[0m "
    read search
    for sea in $search ; do
        if [ $sea = "return" ] ; then
            break
        else
            searchterm='.'$(echo "$sea" | cut -d "." -f 2)                                              #Takes the inputted string, removes a period if one is present, then adds a period,
            echo 'Counting '$searchterm'...'                                                            #this ensures that the filetype is always in the form '.extention'
            count=$(find -path "*/.*" -prune -o -type f | grep -E "$searchterm$" | wc -l)               #Finds all files in folders that are not hidden 
            echo "$count"                                                                               #and uses wc -l to count each new line with one file per line 
        fi 
    done                                                                                             
}                                                                                                   

filesizelist(){
    IFS=$'\n'
    ls -ashS $(find -type f | grep -v "/.git")                                                  #Finds all files in the directory and all subdirectories then, lists them all in human understood
    unset IFS                                                                                   #sizing and sorts this list from greatest to smallest
}

main(){
    if [ $# -gt 0 ] ; then
        for ans in $arguments ; do
            if [ $ans = "fixme" ] ; then
                fixme
            elif [ $ans = "filecount" ] ; then
                filecount
            elif [ $ans = "filesizelist" ]  ; then
                filesizelist
            elif [ $ans = "input" ]  ; then
                input
            else
                echo "$ans is not a function"
            fi
        done
    else
        input
    fi
}

main $arguments
