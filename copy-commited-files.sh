#!/bin/bash
# This script will copy files in given commit from "WORKING TREE" 
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

# Print commit message
echo "--------------------------- Commit Message -------------------------------"
git --git-dir "$repositoryPath/.git" log --format=%B -n 1 $commitId
echo "--------------------------------------------------------------------------"

# Get files in given commit
git --git-dir "$repositoryPath/.git" diff-tree --no-commit-id --name-only -r $commitId | {
while IFS= read -r line
do
    echo $line
    ((var++))
    if [[ $line == *.java ]]; then        
        regex="(.*)src/main/java/(.*).java"
        [[ "$line" =~ $regex ]]        
        #echo "===second group===" "${BASH_REMATCH[1]}"
        #echo "***third group***" "${BASH_REMATCH[2]}"        
        classFilePath="$repositoryPath/${BASH_REMATCH[1]}target/classes/${BASH_REMATCH[2]}(\\$.*)?.class"
        #echo "### " $classFilePath
        classFileName=$(basename "$classFilePath")        
        classDirectory=$(dirname "$classFilePath")        

        classWebAppDirectory="$destinationDirectory/ROOT/WEB-INF/classes/$(dirname ${BASH_REMATCH[2]})"
        if [ ! -d "$classWebAppDirectory" ]; then
            mkdir -p "$classWebAppDirectory"
        fi

        find "$classDirectory" -maxdepth 1 -regextype posix-extended -regex ".*"$classFileName"$"  -exec cp -t "$classWebAppDirectory" {} +

    else
        regex="(.*)src/main/webapp/(.*)"
        [[ "$line" =~ $regex ]]        
        #echo "===second group===" "${BASH_REMATCH[1]}"
        #echo "***third group***" "${BASH_REMATCH[2]}"    
        fileWebAppDirectory="$destinationDirectory/ROOT/$(dirname ${BASH_REMATCH[2]})"
        if [ ! -d "$fileWebAppDirectory" ]; then
            mkdir -p "$fileWebAppDirectory"
        fi
        filePath="$repositoryPath/$line"
        cp "$filePath" "$fileWebAppDirectory"
    fi    
done  
echo "-------------------------------------------------------------------------"
echo "Total files in commit : " $var
echo "-------------------------------------------------------------------------"
}

find "$destinationDirectory/ROOT" -type f|sed "s#$destinationDirectory/##">"$destinationDirectory.txt"