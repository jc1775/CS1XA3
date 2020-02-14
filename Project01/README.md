# CS 1XA3 Project01 - calarcoj

## Index:
- [Usage](#usage)
  - [Script Input](#script-input)
- [Features](#features)
  - [FIXME Log](#1-fixme-log)
  - [File Type Count](#2-file-type-count)
  - [File Size List](#3-file-size-list)
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

***-All features that prompt for user input accept multiple arguments seperated by a space***

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

<filecount> This feature prompts the user to input the intended file extention (i.e txt, pdf, py, .sh, etc...) and proceeds to count the number of files within the working directory and all subdirectoies with said extention and outputs the result. Note that extentions can be entered either as '.extentionname' or 'extentionname', the feature works in either case.

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
___
## Custom Features

___
### 1. File Sort
#### Description: 

<fileSort> This feature will prompt the user for a specific filetype and directory, and search within the specified directory and its subdirectories for all matching files and sort them into a directory named after its contained filetype. If 'tag' is selected it will sort a file into a subdirectory based on a 'tag' within the file name. If 'all' is specified it will proceed to sort all files of which there are at least two occurrences of that filetype, and sort all tags into their respected folders. A log of all previous locations will be kept. This feature will be interactive and guide the user through the process.

#### Execution:

Input:

    some code

Example Output:

>some output

___
### 2. Script Finder
#### Description:

<scriptFind> This feature will recurse through a directory and all subdirectories, finding all script files based on their shebangs, it will copy all scripts into a 'Script' folder sorted into subdirectories based on the interpreter required to run each script. This feature will also give an option to mass change the permissions of each file type in the '/Script' directory.

#### Execution:

Input:

    some code

Example Output:

>some output

#### Reference:
 
some code was taken from 
___