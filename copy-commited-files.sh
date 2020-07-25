#!/bin/bash
# This script will copy files in given commit
# class files will be copied instead of java file

# If commit id is not given then exit
if [[ $# -eq 0 ]] ; then
    echo 'Please, supply commit id'
    exit 0
fi

# Get commit id from command line args
commitId=$1

# git repo path
repositoryPath="/home/intel/git/old"

# Destination directory for putting copied files
destinationDirectory="/home/intel/git/old"

# Use current directory as git repo path if not set
if [[ -z "$repositoryPath" ]]; then
    repositoryPath=$(pwd)
fi
echo "Repository location : " $repositoryPath

# Use current directory as destination directory if not set
if [[ -z "$destinationDirectory" ]]; then
    destinationDirectory=$(pwd)
fi
destinationDirectory=$destinationDirectory"/commit-files/"
echo "Destination directory : " $destinationDirectory

# Check if destination directory exist and create one if not
if [ ! -d "$destinationDirectory" ]; then
    mkdir -p "$destinationDirectory"
fi

# Delete if directory of this commit already exist
if [ -d "$destinationDirectory/$commitId" ]; then
    rm -r "$destinationDirectory/$commitId"
fi

# Create directory for this commit id
mkdir "$destinationDirectory/$commitId"
destinationDirectory=$destinationDirectory"/"$commitId

# Create file to store file list
touch "$destinationDirectory/$commitId"

# Get files in given commit
git --git-dir "$repositoryPath/.git" diff-tree --no-commit-id --name-only -r $commitId | {
while IFS= read -r line
do
    #echo $line    
    if [[ $line == *.java ]]; then        
        regex="(.*)src/main/java/(.*).java"
        [[ "$line" =~ $regex ]]        
        echo "===second group===" "${BASH_REMATCH[1]}"
        echo "***third group***" "${BASH_REMATCH[2]}"        
        classFilePath="$repositoryPath/${BASH_REMATCH[1]}target/classes/${BASH_REMATCH[2]}(\\$.*)?.class"
        echo "### " $classFilePath
        classFileName=$(basename "$classFilePath")
        echo ">>>" $classFileName
        classDirectory=$(dirname "$classFilePath")
        echo "<<<" $classDirectory

        find "$classDirectory" -maxdepth 1 -regextype posix-extended -regex ".*"$classFileName"$"  -exec cp -t "$destinationDirectory" {} +

    else
        filePath="$repositoryPath/$line"
        cp "$filePath" "$destinationDirectory"
    fi    
done

  
}