# CS 1XA3 Project01 - calarcoj

## Index:
- [Usage](#usage)
  - [Script Input](#script-input)
- [Features](#features)
  - [FIXME Log](#1-fixme-log)
  - [File Type Count](#2-file-type-count)
  - [File Size List](#3-file-size-list)
  - [Backup and Delete / Restore](#4-backup-and-delete-/-restore)
  - [Switch To Executable](#5-switch-to-executable)
- [Custom Features](#custom-features)
  - [File Type Sort](#1-file-type-sort)
  - [Script Finder](#2-script-finder)
___ 
## Usage
Execute this script from project root with:


    chmod +x CS1XA3/Project01/project_analyze.sh
    ./CS1XA3/Project01/project_analyze.sh arg1 arg2 ...


With possible arguments:

    fixme
    filecount
    filesizelist
    input

***-If no arguments are given the 'input' feature is executed by default***

### Script Input:

This is an interactive script for selecting and running all other features. It prompts the user to input the name of the desired feature, and accepts multiple arguments at once executing them in the order listed. This script also contains a 'help' menu which lists the name of all features and provides basic information on each one.

#### Example Output:

```
./CS1XA3/Project01/project_analyze.sh
>> Which feature(s) would you like to execute? (Type 'help' for a list of commands, 'exit' to exit):
'some command(s)'
```

#### Unique Arguments:

    help    -   Pulls up an interactive help menu with information on each feature
    exit    -   Ends the script

***-All features that prompt for user input accept 'return' as an argument to return to feature selection***

***-All features that prompt for user input accept multiple arguments***

___
___

## Features

### 1. FIXME Log
#### Description:

<fixme> This feature searches through every file within the working directory and its subdirectories for files where the last line contains '#FIXME'. It creates or overwrites a file 'fixme.log' containing the names and relative directories of all matching files, each to its own line.

#### Execution:

#### Input:

    ./CS1XA3/Project01/project_analyze.sh fixme

#### Example Output:

    ./CS1XA3/Project01/project_analyze.sh fixme
    >>  file-to-fix-1
        file-to-fix-2
        file-to-fix-3
        file-to-fix-4
        etc...

#### Note:
 
***-This feature ignores the '/.git' directory***
___
### 2. File Type Count
#### Description:

<filecount> This feature prompts the user to input the intended file extention (i.e txt, pdf, py, .sh, etc...) and proceeds to count the number of files within the working directory and all subdirectoies with said extention and outputs the result. Note that extensions can be entered either as '.extentionname' or 'extentionname', the feature works in either case.

#### Execution:

#### Input:

    ./CS1XA3/Project01/project_analyze.sh filecount

#### Example Output:

    ./CS1XA3/Project01/project_analyze.sh filecount
    >> What file type would you like to count?:
    '.some-extention'
    >> Counting '.some-extention'...
    'amount'

#### Note:

***-If no arguments are given, this feature will count ALL files***

***-This feature ignores hidden directories and their contents***
 
 
___
### 3. File Size List
#### Description:

<filesizelist> This feature lists all of the files within the working directory and subdirectories, it lists the sizes of the files in a human understood format and sorts them by said size from largest to smallest.

#### Execution:

#### Input:

    ./CS1XA3/Project01/project_analyze.sh filesizelist

#### Example Output:

    ./CS1XA3/Project01/project_analyze.sh filesizelist
    >> 100K 'file-1'    70K 'file-4'
        90K 'file-2'    60K 'file-5'
        80K 'file-3'    etc...

#### Note:
 
***This feature ignores the "/.git" directory***
 
___

### 4. Backup and Delete / Restore

#### Description:

<backupDelRest> This feature prompts the user to either enter 'backup' or 'restore'.<br><br>'Backup': If this is chosen the script proceeds to find all files in a directory and its subdirectories of type '.tmp', copies them to a directory named '/backup', saves a log of the original location to 'backup/backup.log', and deletes the originals.<br><br>'Restore': If this is chosen the script will return all files in the '/backup' directory to their original location using the 'backup.log' file.

#### Execution:

#### Input:

    ./CS1XA3/Project01/project_analyze.sh backupDelRest

#### Example Output:
Backup:

    ./CS1XA3/Project01/project_analyze.sh backupDelRest
    >>Enter 'backup' to create a backup log and directory, moving in all '.tmp' files, and/or 'restore' to reinstate files from the previous backup.
    backup
    >>  file1 backedup succesfully
        file2 backedup succesfully
        file3 already exists within backup! Processing duplicate...
        file3 backedup succesfully
        
Restore:

    ./CS1XA3/Project01/project_analyze.sh backupDelRest
    >>Enter 'backup' to create a backup log and directory, moving in all '.tmp' files, and/or 'restore' to reinstate files from the previous backup.
    restore
    >>  file1 restored succesfully!
        file2 restored succesfully!
        etc...
        
#### Alternate outcomes:

"No new files to backup! Backup ended."  - This occurs when there is nothing to backup

"An error occurred during backup so file deletion did not occur" - This occurs if there is an error in copying to the backup folder, original files will not be deleted.

"ERROR! 'filename' does not exist in backup." - This occurs when a file in the backup log is no longer in the backup folder

"ERROR! restore.log does not exist!" - This occurs when a restore is attempted with no restore.log file to pull information from

#### Note:

***-This feature does not ignore hidden files or hidden folders. HOWEVER it does ignore the /.git directory***
___

### 5. Switch to Executable

#### Description:

<switchEx> This feature finds all files of type '/sh' and creates a 'permission.log' file. It then prompts the user to either 'change' or 'restore' file permissions. If 'change' is chosen then all current permissions are saved into 'permission.log' and then gives any user who currently has write permissions executable permissions. If restore is chosen, all files are restored to their original permissions.

#### Execution:

Change:

    ./CS1XA3/Project01/project_analyze.sh switchEx
    >>  Enter 'change' to allow users with write permissions to execute files, or 'restore' to revert back to original permissions.
    change
    >>  Permission for 'file1.sh' changed!
        Permission for 'file2.sh' changed!
        ...
        Complete

Restore:

    ./CS1XA3/Project01/project_analyze.sh switchEx
    >>  Enter 'change' to allow users with write permissions to execute files, or 'restore' to revert back to original permissions.
    restore
    >>  Permission for 'file1.sh' restored!
        Permission for 'file2.sh' restored!
        ...
        Complete

#### Alternate Outcomes:

"ERROR! 'permissions.log' missing!" - This occurs during a restore if the permissions.log file was removed
___
___
## Custom Features

___
### 1. File Type Sort
#### Description: 

<filesort> This feature allows the user to sort through files within directories in various ways. The user can sort by extention, which will sort all files of a particular type into a directory named after the type. The user can sort by 'tag' which will match each file with a name beginning with a name matching a current existing directory and copy them in. The user can sort 'all' files which will subsequently get every type of extention which occurs at least twice and group them into directories based on the extention type, and then proceed to run a tag sort. The feature keeps a log of original locations in a directory named 'SORTEDlogs', each file type has its own .log file, as well as tag sort having its own file. 

#### Execution:

Input:

    ./CS1XA3/Project01/project_analyze.sh filesort

Example Output:

Tag Sort:

    ./CS1XA3/Project01/project_analyze.sh filesort
    >> How would you like to sort?
    tag
    >> What directories would you like to sort? Seperate directories with a ';'
    directoryA;directoryB;directoryC/anotherDirectoryC
    >> How far would you like to decend into directory: directoryA ?
    "someInteger"
    >>Sorting inside directoryA ...
    >> Would you like to delete files from their original location?[y/n]
    n
    >>  TAG1file1 succesfully sorted into: TAG1
        TAG1file2 succesfully sorted into: TAG1
        TAG2file3 succesfully sorted into: TAG2

Extention Sort:

    ./CS1XA3/Project01/project_analyze.sh filesort
    >> How would you like to sort?
    ext
    >> What directories would you like to sort? Seperate directories with a ';'
    directoryA;directoryB;directoryC/anotherDirectoryC
    >> How far would you like to decend into directory: directoryA ?
    "someInteger"
    >> What extention/s would you like to sort? Seperate with ':'
    .someExtentionA;someExtentionB;.someExtentionC
    >>  Sorting .someExtentionA ...
        file1.someExtentionA sucessfully sorted into someExtentionA
        file2.someExtentionA succesfully sorted into someExtentionA

Sort All:

    ./CS1XA3/Project01/project_analyze.sh filesort
    >> How would you like to sort?
    all
    >> What directories would you like to sort? Seperate directories with a ';'
    directoryA;directoryB;directoryC/anotherDirectoryC
    >> How far would you like to decend into directory: directoryA ?
    "someInteger"
    >>  Sorting: .someExtentionA ...
        file1.someExtentionA succesfully copied into someExtentionA
        file2.someExtentionA succesfully copied into someExtentionA
        Sorting: .someExtentionB ...
        file1.someExtentionB succesfully copied into someExtentionB
        file2.someExtentionB succesfully copied into someExtentionB
        Tag sorting...

#### Alternate outcomes:

"ERROR: $depth is not a number. Please enter an integer." - This occurs when the user inputs a non-integer when asked to input an integer for depth

"Processing file duplication for $file ..." - When the same file already exists in a directory during an 'All' sort the script proceeds to rename the copied file using the parent folder of the file

"Would you like to replace folder/nameProp with file ?\[y/n] Or would you like to add a duplicate of file ?\[d]" - This occurs when a file already exists during tag sort or ext sort allowing the user to choose between replacing the file, adding a duplicate, or keeping the file

#### Note:
 
***When enter directories containing blank spaces DO NOT use quotations: Do- this folder has spaces/anotherfolder Don't- "this foler has spaces/anotherfolder"***
___
### 2. Script Finder
#### Description:

<scriptfind> This feature will recurse through a directory and all subdirectories, finding all script files based on their shebangs, it will copy all scripts into a 'Script' folder sorted into subdirectories based on the interpreter required to run each script. This feature will also give an option to mass change the permissions of each file type in the '/Script' directory. When running 'change' the user is prompted for input as to how to change the permissions for each script, this can be inputted in the usual manner for 'chmod' with +/- w/r/x

#### Execution:

Find:

    ./CS1XA3/Project01/project_analyze.sh scriptfind
    >>  Please enter 'find' to find scripts and/or 'change to change permissions
    find
    >>  Script: 'file1.sh' found and copied into ./Scripts.bash
        Script: 'file2.sh' found and copied into ./Scripts.bash
        'file1.sh' already exists in ./Scripts/bash
         Would you like to replace the file in: ./Scripts/bash ?[y/n] Or would you like create a duplicate?[d]
    d
    >>  Processing file duplication for 'file1.sh' ...
        Script 'file1.sh' copied into ./Scripts/bash as <parentfolder>file1.sh


    

Change:

    ./CS1XA3/Project01/project_analyze.sh scriptfind
    >>  Please enter 'find' to find scripts and/or 'change to change permissions
    change
    >>  Which scripts would you like to change the permissions of? *Case sensitive
    python3
    >>  How would you like to change the permissions of ALL python3 files?
        +wrx
    >>  Permissions for file1.py change succesfully. New permissions: -rwxrwxrwx
        Permissions for file2.py change succesfully. New permissions: -rwxrwxrwx
#### Alternate Outcomes:
 
rm: remove write-protected regular file 'somefile1.sh'? - This occurs if the files currently in the '/Script' directory are write protected, user is asked for conformation on deletion

 "ERROR: There are no 'filetype' scripts to change!" - This occurs if there is no directory for files of type 'filetype'

___