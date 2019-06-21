#!/bin/bash

source config.sh

function create-project() {
    NAME=$1
    LOWER_NAME=`echo $NAME | perl -ne 'print lc'`
    echo "Creating Project \"$NAME\""

    cd $PA_PROJECT_DIRECTORY
    mkdir $NAME
    cd $NAME

    # Create folders within the project
    for FOLDER in ${PA_PROJECT_FOLDERS[*]}
    do
        mkdir $FOLDER
    done

    # Delete previous repo (only for testing)
    # curl --request DELETE -H "Authorization: token $PA_GITHUB_PAT" https://api.github.com/repos/wolfiezero/$LOWER_NAME

    # Create the repo and store the clone URL
    GITHUB_CLONE_URL=$(curl --request POST --data "{\"name\": \"$LOWER_NAME\", \"private\": true}" -H "Authorization: token $PA_GITHUB_PAT" https://api.github.com/user/repos | jq -r '.ssh_url')

    git clone $GITHUB_CLONE_URL
    cd $LOWER_NAME
    git checkout -b develop
    code .
}
