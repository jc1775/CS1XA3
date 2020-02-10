# CS 1XA3 Project01 - calarcoj

## Index:

- [Features](#features)
  - [Script Input](#1-script-input)
  - [FIXME Log](#2-fixme-log)
  - [File Type Count](#3-file-type-count)
  - [File Size List](#4-file-size-list)
  - [Backup and Delete / Restore](#5-backup-and-delete-%2F-restore)
  - [Switch To Executable](#6-switch-to-executable)
- [Custom Features](#custom-features)
  - [File Type Sort](#1-file-type-sort)
  - [abcd](#2-abcd)
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
    switchEx
    backupDelRest

___If no arguments are given the 'input' feature is executed by default___
___
___

## Features
___
### 1. Script Input
#### Description:

This is an interactive script for selecting and running all other features. It prompts the user to input the name of the desired feature, and accepts multiple arguments at once executing them in the order listed. This script also contains a 'help' menu which lists the name of all features and provides basic information on each one.

#### Execution:

Input:

This feature executes by default when no arguments are given:

    ./CS1XA3/Project01/project_analyze.sh

However it can also be executed directly:

    ./CS1XA3/Project01/project_analyze.sh input

Example Output:

```
./CS1XA3/Project01/project_analyze.sh
>> Which feature(s) would you like to execute? (Type 'help' for a list of commands, 'exit' to exit):
'some command(s)'
```

#### Unique Arguments:

    help    -   Pulls up an interactive help menu with information on each feature
    exit    -   Ends the script

#### Reference:

some code was taken from 
___
### 2. FIXME Log
#### Description:

<fixme> This feature searches through every file within the working directory and its subdirectories for files where the last line contains '#FIXME'. It creates or overwrites a file 'fixme.log' containing the names and relative directories of all matching files, each to its own line.

#### Execution:

Input:

    ./CS1XA3/Project01/project_analyze.sh fixme

Example Output:

    ./CS1XA3/Project01/project_analyze.sh fixme
    >>  file-to-fix-1
        file-to-fix-2
        file-to-fix-3
        file-to-fix-4
        etc...

#### Reference:
 
some code was taken from 
___
### 3. File Type Count
#### Description:

<filecount> This feature prompts the user to input the intended file extention (i.e txt, pdf, py, .sh, etc...) and proceeds to count the number of files within the working directory and all subdirectoies with said extention and outputs the result. Note that extentions can be entered either as '.extentionname' or 'extentionname', the feature works in either case.

#### Execution:

Input:

    ./CS1XA3/Project01/project_analyze.sh filecount

Example Output:

    ./CS1XA3/Project01/project_analyze.sh filecount
    >> What file type would you like to count?:
    '.some-extention'
    >> Counting '.some-extention'...
    'amount'

#### Reference:
 
some code was taken from 
___
### 4. File Size List
#### Description:

<filesizelist> This feature lists all of the files within the working directory and subdirectories, it lists the sizes of the files in a human understood format and sorts them by said size from largest to smallest.

#### Execution:

Input:

    ./CS1XA3/Project01/project_analyze.sh filesizelist

Example Output:

    ./CS1XA3/Project01/project_analyze.sh filesizelist
    >> 100K 'file-1'    70K 'file-4'
        90K 'file-2'    60K 'file-5'
        80K 'file-3'    etc...

#### Reference:
 
some code was taken from 

___

### 5. Backup and Delete / Restore

#### Description:

<backupDelRest> abc

#### Execution:

Input:

    abc

Example Output:

    abc

#### Reference:
 
some code was taken from 
___

### 6. Switch to Executable

#### Description:

<switchEx> abc

#### Execution:

Input:

    abc

Example Output:

    abc

#### Reference:
 
some code was taken from 
___
___
## Custom Features

___
### 1. File Type Sort
#### Description: 

<fileSort> This feature will promt the user for a specific filetype and directory, and search within the specified directory and its subdirectories for all matching files and sort them into a directory named after its contained filetype. If 'all' is specified it will proceed to sort all files of which there are at least two occurrences of that filetype. A log of all previous locations will be kept. This feature will be interactive and guide the user through the process.

#### Execution:

Input:

    some code

Example Output:

>some output

#### Reference:
 
some code was taken from 
___
### 2. abcd
#### Description:

<font color="green">This feature does ....</font>

#### Execution:

Input:

    some code

Example Output:

>some output

#### Reference:
 
some code was taken from 
___
<readme0>
