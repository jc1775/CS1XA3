#!/bin/bash
. main.sh
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


