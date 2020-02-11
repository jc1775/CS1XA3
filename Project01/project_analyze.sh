#!/bin/bash

heirarchy="$( echo "$0" | rev | cut -d "/" -f 2- | rev)"
arguments="$@"

input() {
    functionlist="\n1. fixme\n2. filecount\n3. filesizelist\n4. backupDelRest\n5. switchEx"

    echo -e "\e[1mWhich feature(s) would you like to execute? (Type 'help' for a list of commands, 'exit' to exit):\e[0m "
    read answer

    while [ "$answer" != "exit" ] ; do
        for ans in $answer ; do
            if [ "$ans" = "help" ] ; then
                echo -e "\e[100m\e[33m\e[4mList of Commands\e[1m\e[24m$functionlist\e[0m"
                while [ $answer != "return" ] ; do
                    echo -e "\e[1mEnter 'return' to return to command selection, or type the name of a function you would like further information on:\e[0m "
                    read answer
                    if [ $answer = "filesizelist" ] ; then
                        echo -e "\e[1m\e[100m$(grep '<filesizelist>' "$heirarchy/README.md")\e[0m"
                    elif [ $answer = "fixme" ] ; then
                        echo -e "\e[1m\e[100m$(grep '<fixme>' "$heirarchy/README.md")\e[0m"
                    elif [ $answer = "filecount" ] ; then
                        echo -e "\e[1m\e[100m$(grep '<filecount>' "$heirarchy/README.md")\e[0m"
                    elif [ $answer = "backupDelRest" ] ; then
                        echo -e "\e[1m\e[100m$(grep '<backupDelRest>' "$heirarchy/README.md")\e[0m"
                    elif [ $answer = "switchEx" ] ; then
                        echo -e "\e[1m\e[100m$(grep '<switchEx>' "$heirarchy/README.md")\e[0m"
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

    searchterm='#FIXME'
    outputfolder="$heirarchy/fixme.log"   
    files=$(rgrep -l "$searchterm")   
    newstring=""   
    IFS=$'\n'
    for file in $files ; do

        if tail -1 "$file" | grep -q "$searchterm" && [ -z "$newstring" ] ; then    #If the last line of the file contains searchterm and the new string is empty
            newstring=$(printf "$file")                                             #Adds the filename to the first line of the new string 
        elif tail -1 "$file" | grep -q "$searchterm" ; then                         #If the newstring is not empty appends the filename to the next line
	    newstring=$(printf "$newstring \n$file")      
        fi    
    done
    unset IFS
    echo "$newstring" > "$outputfolder"   
    cat "$outputfolder"

}

filecount(){

    echo -e "\e[1mWhat file type would you like to count?:\e[0m "
    read search
    searchterm='.'$(echo "$search" | cut -d "." -f 2)                               #Takes the inputted string, removes a period if one is present, then adds a period,
    echo 'Counting '$searchterm'...'                                                #this ensures that the filetype is always in the form '.extention'
    count=$(ls -aRp | grep -v / | grep -E "$searchterm$" | wc -l)                   #Recurses through the directories listing everything, adds a / to the end of directories 
    echo "$count"                                                                   #then uses grep to remove everything with '/' proceeds to search for the extention at the end  
}                                                                                   #of all remaining files, then counts them

filesizelist(){
    IFS=$'\n'
    ls -shS $(find -type f)                                                        #Finds all files in the directory and all subdirectories then, lists them all in human understood
    unset IFS                                                                      #sizing and sorts this list from greatest to smallest
}


switchEx() {

    executables="$(find -type f | grep -v "project_analyze.sh" | grep -E ".sh$")"

    if ! [ -f "$heirarchy/permissions.log" ] ; then
        touch "$heirarchy/permissions.log"
    fi

    echo -e "\e[1mEnter 'change' to allow users with write permissions to execute files, or 'restore' to revert back to original permissions.\e[0m" 
    read response

    if [ $response = "change" ] || [ $response = "Change" ] ; then
        IFS=$'\n'
        ls -l $executables > "$heirarchy/permissions.log"
        for exec in $executables ; do
            if [ "$(ls -l "$exec" | cut -c 3)" = "w" ] ; then
                chmod u+x "$exec"
                if [ $? -eq 0 ] ; then
                    echo "Permission for "$exec" changed!"
                else
                    echo "There was an error changing permissions for $exec!"
                fi
            fi
        done
        unset IFS
        echo "Complete"
    elif [ $response = "restore" ] || [ $response = "Restore" ] ; then
        IFS=$'\n'
        for file in $executables ; do
            permissions="$(grep -E "$file$" "$heirarchy/permissions.log" | cut -c 2-4)"
            chmod +"$permissons" "$file"
            if [ $? -eq 0 ] ; then
                    echo "Permissions for $file restored!"
            else
                echo "There was an error restoring permissions for $exec!"
            fi    
        done
        unset IFS
        echo "Complete"
    else
        echo "$response is not a command in this feature"
    fi
}

backupDelRest(){

    backupType=".pdf"
    echo -e "\e[1mEnter 'backup' to create a backup log and directory, moving in all '.tmp' files, and/or 'restore' to reinstate files from the previous backup.\e[0m"
    read response

    for res in $response ; do
        if [ $res = "backup" ] || [ $res = "Backup" ] ; then
            if find -path "$heirarchy/backup" -prune -o -type f | grep -qE "$backupType$" ; then
                if ! [ -d "$heirarchy/backup" ] ; then
                    mkdir "$heirarchy/backup"
                else
                    rm -r "$heirarchy/backup"
                    mkdir "$heirarchy/backup"
                fi
                find -type f | grep -E "$backupType$" > "$heirarchy/backup/restore.log"
                IFS=$'\n'
                cp $(ls -aRp $(find -type f) | grep -E "$backupType$") "$heirarchy/backup"
                if [ $? -eq 0 ] ; then
                    rm $(cat "$heirarchy/backup/restore.log")
                    echo "Backup succesful"
                else
                    echo "An error occurred during backup so file deletion did not occur"
                fi
            else
                echo "No new files to backup! Backup ended."
            fi
                unset IFS
        elif [ $res = "restore" ] || [ $res = "Restore" ] ; then
            IFS=$'\n'
            for filepath in $(cat "$heirarchy/backup/restore.log") ; do
                fileName="$(echo "$filepath" | rev | cut -d "/" -f 1 | rev)"
                origPath="$(echo "$filepath" | rev | cut -d "/" -f 2- | rev)"
                if ! [ -e "$heirarchy/backup/$fileName" ] ; then
                    echo "ERROR! $fileName does not exist in backup."
                else
                    cp "$heirarchy/backup/$fileName" "$origPath"
                    echo "$fileName restored succesfully!"
                fi
            done
            unset IFS
        else
            echo "$res is not a command in this feature."
        fi 
    done
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
            elif [ $ans = "backupDelRest" ] ; then
                backupDelRest
            elif [ $ans = "switchEx" ] ; then
                switchEx
            else
                echo "$ans is not a function"
            fi
        done
    else
        input
    fi
}

main $arguments