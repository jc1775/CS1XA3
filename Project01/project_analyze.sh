#!/bin/bash


heirarchy="$( echo "$0" | rev | cut -d "/" -f 2- | rev)"
arguments="$@"

input() {
    functionlist="\n1. fixme\n2. filecount\n3. filesizelist\n4. backupDelRest\n5. switchEx\n6. filesort\n7. scriptfind"

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
                        elif [ $ans = "backupDelRest" ] ; then
                            echo -e "\e[1m\e[100m$(grep '<backupDelRest>' "$heirarchy/README.md")\e[0m"
                        elif [ $ans = "switchEx" ] ; then
                            echo -e "\e[1m\e[100m$(grep '<switchEx>' "$heirarchy/README.md")\e[0m"
                        elif [ $ans = "filesort" ] ; then
                            echo -e "\e[1m\e[100m$(grep '<filesort>' "$heirarchy/README.md")\e[0m"
                         elif [ $ans = "scriptfind" ] ; then
                            echo -e "\e[1m\e[100m$(grep '<scriptfind>' "$heirarchy/README.md")\e[0m"
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
            elif [ $ans = "filesort" ] ; then
                filesort
            elif [ $ans = "scriptfind" ] ; then
                scriptfind
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
            count=$(find -path "$heirarchy/.*" -prune -o -type f | grep -E "$searchterm$" | wc -l)      #Finds all files in folders that are not hidden 
            echo "$count"                                                                               #and uses wc -l to count each new line with one file per line 
        fi 
    done                                                                                             
}                                                                                                   

filesizelist(){
    IFS=$'\n'
    ls -ashS $(find -type f | grep -v "/.git")                                                  #Finds all files in the directory and all subdirectories then, lists them all in human understood
    unset IFS                                                                                   #sizing and sorts this list from greatest to smallest
}

switchEx() {

    executables="$(find -type f | grep -E ".sh$")"

    if ! [ -f "$heirarchy/permissions.log" ] ; then
        touch "$heirarchy/permissions.log"
    fi

    echo -e "\e[1mEnter 'change' to allow users with write permissions to execute files, or 'restore' to revert back to original permissions.\e[0m" 
    read response
    for res in $response ; do
        if [ $res = "change" ] || [ $res = "Change" ] ; then
            IFS=$'\n'
            ls -l $executables > "$heirarchy/permissions.log"
            for exec in $executables ; do
                if [ "$(ls -l "$exec" | cut -c 3)" = "w" ] ; then
                    chmod u+x "$exec"
                    if [ $? -eq 0 ] ; then
                        echo "Permission for "$exec" changed!"
                    else
                        echo "There was an ERROR changing permissions for $exec!"
                    fi
                fi
            done
            unset IFS
            echo "Complete"
        elif [ $res = "restore" ] || [ $res = "Restore" ] ; then
            if ! [ -f "$heirarchy/permissions.log" ] ; then
                echo "ERROR! 'permissions.log' missing!"
            fi
            IFS=$'\n'
            for file in $executables ; do
                permissions="$(grep -E "$file$" "$heirarchy/permissions.log" | cut -c 2-4)"
                chmod +"$permissons" "$file"
                if [ $? -eq 0 ] ; then
                        echo "Permissions for $file restored!"
                else
                    echo "There was an ERROR restoring permissions for $exec!"
                fi    
            done
            unset IFS
            echo "Complete"
        elif [ $res = "return" ] ; then
            break
        else
            echo "$res is not a command in this feature"
        fi
    done
    unset IFS
}

backupDelRest(){

    backupType=".tmp"
    echo -e "\e[1mEnter 'backup' to create a backup log and directory, moving in all '.tmp' files, and/or 'restore' to reinstate files from the previous backup.\e[0m"
    read response

    for res in $response ; do
        if [ $res = "backup" ] || [ $res = "Backup" ] ; then
            if find -path "$heirarchy/backup" -prune -o -type f | grep -qE "$backupType$" ; then
                if [ -d "$heirarchy/backup" ] ; then
                    rm -r "$heirarchy/backup"
                fi
                mkdir "$heirarchy/backup"
                touch "$heirarchy/backup/restore.log"
                files="$(find -type f | grep -E "$backupType$" | grep -vE "*/.git/*")"
                IFS=$'\n'
                
                for file in $files; do
                    nameProp="$(echo $file | rev | cut -d "/" -f 1 | rev)"
                    parentFolder="$( echo "$file" | rev | cut -d "/" -f 2 | rev )"
                    if ! [ -f "$heirarchy/backup/$nameProp" ] ; then
                        cp "$file" "$heirarchy/backup"
                        if [ $? -eq 0 ] ; then
                            rm "$file"
                            echo "$file backedup succesfully"
                            echo "ORIGINAL>$file>ORIGINAL NEW>$heirarchy/backup/$nameProp>NEW" >> "$heirarchy/backup/restore.log"
                        else
                            echo "An ERROR occurred during backup, file was not deleted"
                        fi
                    else
                        echo "$file already exists within $heirarchy/backup! Processing duplicate..."
                        cp "$file" "$heirarchy/backup/$parentFolder-$nameProp"
                        if [ $? -eq "0" ] ; then
                            rm "$file"
                            echo "$file backedup succesfully"
                            echo "ORIGINAL>$file>ORIGINAL NEW>$heirarchy/backup/$parentFolder-$nameProp>NEW" >> "$heirarchy/backup/restore.log"
                        else
                            echo "An ERROR occurred during backup, file was not deleted"
                        fi
                    fi
                done
            else
                echo "No new files to backup! Backup did not occur."
            fi
                unset IFS
        elif [ $res = "restore" ] || [ $res = "Restore" ] ; then
            IFS=$'\n'
            if [ -f "$heirarchy/backup/restore.log" ] ; then
                for fileInfo in $(cat "$heirarchy/backup/restore.log") ; do
                    currentName="$(echo $fileInfo | rev | cut -d ">" -f 2 | rev)"
                    origName="$(echo $fileInfo | cut -d ">" -f 2)"
                    properName="$(echo $currentName | rev | cut -d "/" -f 1 | rev)"
                    if ! [ -f "$heirarchy/backup/$properName" ] ; then
                        echo "ERROR! $currentName does not exist in backup."
                    else
                        cp "$currentName" "$origName"
                        echo "$origName restored succesfully"
                    fi
                done
            else
                echo "ERROR! restore.log does not exist!"
            fi
            unset IFS
        elif [ $res = "return" ] ; then
            break
        else
            echo "$res is not a command in this feature."
        fi 
    done
    unset IFS
}

filesort() {

    echo "How would you like to sort?"
    read sorttype
    if [ $sorttype = "return" ] || [ $sorttype = "Return" ] ; then
        return
    fi
    echo "Which directories would you like to sort? Seperate directories with a ';'"
    read directory
    directory="$(sed 's/;/\n/g' <<< $directory )"

    IFS=$'\n'
    for type in $sorttype ; do
        for dir in $directory ; do
            if ! [ -d "$dir" ] ; then
                echo "$dir is not a directory!"
                continue
            fi

            if ! [ -d "$dir/SORTEDlogs" ] ; then
                mkdir "$dir/SORTEDlogs"
            fi

            echo "How far would you like to decend into the directory: $dir?"
            read depth
            
            ###
            intChk='^[0-9]+$'
            while ! [[ "$depth" =~ $intChk ]] ; do
                echo "ERROR: $depth is not a number. Please enter an integer."
                echo "How far would you like to decend into the directory: $dir?"
                read depth
            done
            ###
            
            echo "Sorting inside $heirarch/$dir ..."
            
            autoExtSort() {
                extentions="$(find "$dir" -maxdepth $depth -type f | rev | cut -d "/" -f 1 | rev | grep "\. *"| rev | cut -d "." -f 1 | rev | grep -vE "log$" )"
                while [ ${#extentions} -gt 0 ] ; do
                    for ext in $extentions ; do
                        searchterm='.'$(echo "$ext" | cut -d "." -f 2) 
                        nameProp="$( echo "$searchterm" | cut -d "." -f 2- )"
                        if [ $(find "$dir" -maxdepth "$depth" -not -path "$nameProp" -type f | grep -E "$searchterm$" | wc -l) -gt "1" ] ; then
                            echo "Sorting: $searchterm ..."
                            if [ -d "$dir/$nameProp" ] ; then
                                rm -r "$dir/$nameProp"
                            fi
                            if [ -f "$dir/SORTEDlogs/$nameProp.log" ] ; then
                                rm "$dir/SORTEDlogs/$nameProp.log"
                            fi

                            mkdir "$dir/$nameProp"
                            touch "$dir/SORTEDlogs/$nameProp.log"
                            files="$(find "$dir" -maxdepth "$depth" -type f | grep -E "$searchterm$")"
                            for file in $files; do
                                origName="$(echo "$file" | rev | cut -d "/" -f 1 | rev )"
                                if ! [ -f "$dir/$nameProp/$origName" ] ; then
                                    cp "$file" "$dir/$nameProp"
                                    if [ $? -eq "0" ] ; then
                                    echo "$file was sorted succesfully into $dir/$nameProp"
                                        echo "$file" >> "$dir/SORTEDlogs/$nameProp.log"
                                    else
                                        echo "There was an ERROR sorting $file"
                                    fi
                                else
                                    echo "Processing file duplication for $file ..."
                                    parentFolder="$( echo "$file" | rev | cut -d "/" -f 2 | rev )"
                                    cp "$file" "$dir/$nameProp/<$parentFolder>$origName"
                                    if [ $? -eq "0" ] ; then
                                        echo "$file:$dir/$nameProp/<$parentFolder>$origName" >> "$dir/SORTEDlogs/$nameProp.log"
                                    else
                                        echo "There was an ERROR sorting $file"   
                                    fi
                                fi
                            done
                            extentions="$(grep -vE "$ext$" <<< "$extentions")"
                            break
                        else
                            extentions="$(grep -vE "$ext$" <<< "$extentions")"
                            break
                        fi
                    done
                done
            }
            tagSort() {
                folderList="$(find "$dir" -not -path '*/\.*' -type d)"
                if [ -f "$dir/SORTEDlogs/SORTEDtag.log" ] ; then
                    rm "$dir/SORTEDlogs/SORTEDtag.log"
                fi
                
                yesono=""
                while ! [ "$yesono" = "y" ] || ! [ "$yesono" = "n" ] ; do                         
                    echo "Would you like to delete files from their original location? [y/n]"
                    read yesono
                    if [ "$yesono" = "y" ] || [ "$yesono" = "n" ] ; then
                        break
                    else
                        echo "ERROR: Please respond with 'y'(Yes) or 'n'(No)!"
                    fi
                done
            
                if [ "$yesono" = "y" ] ; then
                    for folder in $folderList ; do
                        fileList="$(find "$dir" -maxdepth "$depth" -type f | grep -vE "$folder/" | grep -vE ".log$" | grep $( echo "$folder" | rev | cut -d "/" -f 1 | rev))"
                        folderName="$( echo "$folder" | rev | cut -d "/" -f 1 | rev)"
                        for file in $fileList ; do
                            if echo "$file" | rev | cut -d "/" -f 1 | rev | grep -qE "^$(echo $folder | rev | cut -d "/" -f 1 | rev)" ; then
                                nameProp="$(echo "$file" | rev | cut -d "/" -f 1 | rev )"
                                if ! [ -f "$folder/$nameProp" ] ; then
                                    cp "$file" "$folder"
                                    if [ $? -eq 0 ] ; then
                                        rm "$file"
                                        echo "$file has been moved into $folder" >> "$dir/SORTEDlogs/SORTEDtag.log"
                                        echo "File: $file succesfully sorted into: $folder !"
                                    else
                                        echo "There was an ERROR copying $file into $folder , your file was not deleted"
                                    fi
                                else
                                    echo "$file already exists in $folder"
                                    
                                    yesono=""
                                    while ! [ "$yesono" = "y" ] || ! [ "$yesono" = "n" ] || ! [ "$yesono" = "d" ] ; do                               
                                        echo "Would you like to replace $folder/$nameProp with $file ?[y/n] Or would you like to add a duplicate of $file ?[d]"       
                                        read yesono     
                                        if [ "$yesono" = "y" ] || [ "$yesono" = "n" ] || [ "$yesono" = "d" ] ; then        
                                            break       
                                        else        
                                            echo "ERROR: Please respond with 'y'(Yes) or 'n'(No) or 'd'(Duplicate)!"      
                                        fi      
                                    done

                                    if [ "$yesono" = "y" ] ; then
                                        rm "$folder/$nameProp"
                                        cp "$file" "$folder"
                                        if [ $? -eq "0" ] ; then
                                            echo "$file succesfully copied into $folder"
                                            echo "$file has been moved into $folder" >> "$dir/SORTEDlogs/SORTEDtag.log"
                                            rm "$file"
                                        else
                                            echo "There was an ERROR copying $file into $folder , your file was not deleted"
                                        fi
                                    elif [ "$yesono" = "d" ] ; then
                                        echo "Processing file duplication for $file ..."
                                        origName="$(echo "$file" | rev | cut -d "/" -f 1 | rev )"
                                        parentFolder="$( echo "$file" | rev | cut -d "/" -f 2 | rev )"
                                        cp "$file" "$folder/<$parentFolder>$origName"
                                        if [ $? -eq "0" ] ; then
                                            echo "$file moved into $folder as: $folder/<$parentFolder>$origName" >> "$dir/SORTEDlogs/SORTEDtag.log"
                                        else
                                            echo "There was an ERROR sorting $file"
                                        fi   
                                    fi        
                                fi
                            fi
                        done
                    done
                elif [ "$yesono" = "n" ] ; then
                    for folder in $folderList ; do
                        fileList="$(find "$dir" -maxdepth "$depth" -type f | grep -vE "$folder/" | grep -vE ".log$" | grep $( echo "$folder" | rev | cut -d "/" -f 1 | rev))"
                        for file in $fileList ; do
                            if echo "$file" | rev | cut -d "/" -f 1 | rev | grep -qE "^$(echo $folder | rev | cut -d "/" -f 1 | rev)" ; then
                                nameProp="$(echo "$file" | rev | cut -d "/" -f 1 | rev )"
                                if ! [ -f "$folder/$nameProp" ] ; then
                                    cp "$file" "$folder"
                                    if [ $? -eq 0 ] ; then
                                        echo "$file has been moved into $folder" >> "$dir/SORTEDlogs/SORTEDtag.log"
                                        echo "File: $file succesfully sorted into: $folder !"
                                    else
                                        echo "There was an ERROR copying $file into $folder , your file was not deleted"
                                    fi
                                else
                                    echo "$file already exists in $folder"
                                    
                                    yesono=""
                                    while ! [ "$yesono" = "y" ] || ! [ "$yesono" = "n" ] || ! [ "$yesono" = "d" ] ; do                               
                                        echo "Would you like to replace $folder/$nameProp with $file ?[y/n] Or would you like to add a duplicate of $file ?[d]"       
                                        read yesono     
                                        if [ "$yesono" = "y" ] || [ "$yesono" = "n" ] || [ "$yesono" = "d" ] ; then        
                                            break       
                                        else        
                                            echo "ERROR: Please respond with 'y'(Yes) or 'n'(No) or 'd'(Duplicate)!"      
                                        fi      
                                    done

                                    if [ "$yesono" = "y" ] ; then
                                        rm "$folder/$nameProp"
                                        cp "$file" "$folder"
                                        if [ $? -eq "0" ] ; then
                                            echo "$file succesfully copied into $folder"
                                            echo "$file has been copied into $folder" >> "$dir/SORTEDlogs/SORTEDtag.log"
                                        else
                                            echo "There was an ERROR copying $file into $folder , your file was not deleted"
                                        fi
                                    elif [ "$yesono" = "d" ] ; then
                                        echo "Processing file duplication for $file ..."
                                        origName="$(echo "$file" | rev | cut -d "/" -f 1 | rev )"
                                        parentFolder="$( echo "$file" | rev | cut -d "/" -f 2 | rev )"
                                        cp "$file" "$folder/<$parentFolder>$origName"
                                        if [ $? -eq "0" ] ; then
                                            echo "$file copied into $folder as: $folder/<$parentFolder>$origName" >> "$dir/SORTEDlogs/SORTEDtag.log"
                                        else
                                            echo "There was an ERROR sorting $file"
                                        fi 
                                    fi        
                                fi
                            fi
                        done
                    done
                fi
            }
            extSort() {
                echo "What extention/s would you like to sort? Seperate with ';'"
                read extention
                extention="$(sed 's/;/\n/g' <<< $extention )"
                for ext in $extention ; do
                    searchterm='.'$(echo "$ext" | cut -d "." -f 2) 
                    echo "Sorting: $searchterm ..."
                    if find "$dir" -maxdepth "$depth" -type f | grep -qE "$searchterm$" ; then
                        nameProp="$( echo "$searchterm" | cut -d "." -f 2- )"
                        if [ -d "$dir/$nameProp" ] ; then
                            rm -r "$dir/$nameProp"
                        fi
                        if [ -f "$dir/SORTEDlogs/$nameProp.log" ] ; then
                            rm "$dir/SORTEDlogs/$nameProp.log"
                        fi

                        mkdir "$dir/$nameProp"
                        touch "$dir/SORTEDlogs/$nameProp.log"
                        files="$(find "$dir" -maxdepth "$depth" -type f | grep -E "$searchterm$")"
                        for file in $files; do
                            origName="$(echo "$file" | rev | cut -d "/" -f 1 | rev )"
                            if ! [ -f "$dir/$nameProp/$origName" ] ; then
                                cp "$file" "$dir/$nameProp"
                                if [ $? -eq "0" ] ; then
                                    echo "$file" >> "$dir/SORTEDlogs/$nameProp.log"
                                    echo "$file succesfully coppied into $nameProp"
                                else
                                    echo "There was an ERROR sorting $file"
                                fi
                            else
                                echo "$file already exists in $folder"
                                    
                                yesono=""
                                while ! [ "$yesono" = "y" ] || ! [ "$yesono" = "n" ] || ! [ "$yesono" = "d" ] ; do                               
                                    echo "Would you like to replace $folder/$nameProp with $file ?[y/n] Or would you like to add a duplicate of $file ?[d]"       
                                    read yesono     
                                    if [ "$yesono" = "y" ] || [ "$yesono" = "n" ] || [ "$yesono" = "d" ] ; then        
                                        break       
                                    else        
                                        echo "ERROR: Please respond with 'y'(Yes) or 'n'(No)!"      
                                    fi     
                                done
                                if [ "$yesono" = "y" ] ; then
                                    rm "$folder/$nameProp"
                                    cp "$file" "$folder"
                                    if [ $? -eq "0" ] ; then
                                        echo "$file succesfully copied into $folder"
                                    else
                                        echo "There was an ERROR copying $file into $folder , your file was not deleted"
                                    fi
                                elif [ "$yesono" = "d" ] ; then
                                    echo "Processing file duplication for $file ..."
                                    parentFolder="$( echo "$file" | rev | cut -d "/" -f 2 | rev )"
                                    cp "$file" "$dir/$nameProp/<$parentFolder>$origName"
                                    if [ $? -eq "0" ] ; then
                                        echo "$file:$dir/$nameProp/<$parentFolder>$origName" >> "$dir/SORTEDlogs/$nameProp.log"
                                    else
                                        echo "There was an ERROR sorting $file"   
                                    fi
                                fi
                            fi
                        done
                    else
                        echo "No files of type $ext found!"
                    fi
                done
                echo "Extention sort complete!"        
            }
            if [ $type = "all" ] || [ $type = "All" ] ; then
                echo "Extention sorting..."
                autoExtSort
                echo "Extention sorting complete!"
                echo "Tag sorting..."
                tagSort
                echo "Tag sorting complete!"
            elif [ $type = "tag" ] || [ $type = "Tag" ] ; then
                tagSort
            elif [ $type = "ext" ] || [ $type = "Ext" ] ; then
                extSort
            else
                echo "$type is not a command in this feature"             
            fi
        done
    done

    unset IFS
}

scriptfind() {
    echo "Please enter 'find' to find scripts and/or 'change' to change permissions"
    read response
    if [ "$response" = "return" ] ; then
        return
    fi
    
    for res in $response ; do
        if [ "$res" = "find" ] || [ "$res" = "Find" ] ; then
            if [ -d "$heirarchy/Scripts" ] ; then
                rm -r "$heirarchy/Scripts"
            fi
            mkdir "$heirarchy/Scripts"
            IFS=$'\n'
            fileList="$( grep -l "#!" $(find -path "$heirarchy/Scripts" -prune -o -type f | grep -v "/Scripts" ))"
            for file in $fileList ; do
                interpreter="$( head -1 $file | rev | cut -d "/" -f 1 | rev )"
                interpreter="$(sed 's/\r$//' <<< "$interpreter")" #Removes DOS characters
                fileName="$(echo $file | rev | cut -d "/" -f 1 | rev)"
                if ! [ -d "$heirarchy/Scripts/$interpreter" ] ; then
                    mkdir "$heirarchy/Scripts/$interpreter"
                fi
                if ! [ -f "$heirarchy/Scripts/$interpreter/$fileName" ] ; then
                    cp "$file" "$heirarchy/Scripts/$interpreter"
                    if [ $? -eq "0" ] ; then
                    echo "Script: $fileName found and copied into $heirarchy/Scripts/$interpreter"
                    fi
                else
                    echo "$fileName already exists in $heirarchy/Scripts/$interpreter"
                    yesono=""
                    while ! [ "$yesono" = "y" ] || ! [ "$yesono" = "n" ] || ! [ "$yesono" = "d" ] ; do                         
                        echo "Would you like to replace the file in: $heirarchy/Scripts/$interpreter ?[y/n] Or would you like create a duplicate?[d]"
                        read yesono
                        if [ "$yesono" = "y" ] || [ "$yesono" = "n" ] || [ "$yesono" = "d" ] ; then
                            break
                        else
                            echo "ERROR: Please respond with 'y'(Yes) or 'n'(No) or 'd'(Duplicate)!"
                        fi
                    done

                    if [ "$yesono" = "y" ] ; then
                        rm "$heirarchy/Scripts/$interpreter/$fileName"
                        cp "$file" "$heirarchy/Scripts/$interpreter"
                        if [ $? -eq "0" ] ; then
                        echo "Script: $fileName succesfully copied into $heirarchy/Scripts/$interpreter"
                        fi
                    elif [ "$yesono" = "d" ] ; then
                        echo "Processing file duplication for $file ..."
                        parentFolder="$( echo "$file" | rev | cut -d "/" -f 2 | rev )"
                        cp "$file" "$heirarchy/Scripts/$interpreter/<$parentFolder>$fileName"
                        if [ $? -eq "0" ] ; then
                            echo "Script: $fileName succesfully copied into $heirarchy/Scripts/$interpreter as <$parentFolder>$fileName "
                        else
                            echo "There was an ERROR copying $file"   
                        fi
                    fi
                fi
            done
        elif [ "$res" = "change" ] || [ "$res" = "Change" ] ; then
            echo "Which scripts would you like to change the permissions of? *Case sensitive"
            read directories
            for dir in $directories ; do
                if ! [ -d "$heirarchy/Scripts/$dir" ] ; then
                    echo "ERROR: There are no $dir scripts to change!"
                else
                    files=$(find "$heirarchy/Scripts/$dir" -type f)
                    echo "How would you like to change the permissions of ALL $dir files?"
                    read permChange
                    for file in $files ; do
                        chmod "$permChange" $file
                        if [ $? -eq "0" ] ; then
                            echo "Permissions for $file change succesfully. New permissions: $(ls -l $file | cut -c -10 | grep -v total)"
                        else
                            echo "There was an error changing permissions for $file"
                        fi
                    done
                fi
            done
        else
            echo "$res is not a command in this feature"
        fi
    done
    unset IFS
}
main(){
    if [ $# -gt 0 ] ; then
        for arg in $arguments ; do
            if [ $arg = "fixme" ] ; then
                fixme
            elif [ $arg = "filecount" ] ; then
                filecount
            elif [ $arg = "filesizelist" ]  ; then
                filesizelist
            elif [ $arg = "input" ]  ; then
                input
            elif [ $arg = "backupDelRest" ] ; then
                backupDelRest
            elif [ $arg = "switchEx" ] ; then
                switchEx
            elif [ $arg = "filesort" ] ; then
                filesort
            elif [ $arg = "scriptfind" ] ; then
                scriptfind
            else
                echo "$arg is not a function"
            fi
        done
    else
        input
    fi
}

main $arguments
