#!/bin/bash

# source config.sh

function create-project() {
    NAME=$1

    # Check if NAME was passed
    if [ -z "$NAME" ]; then
        echo "No name given..."
        return
    fi

    # Make lowercase version of NAME
    LOWER_NAME=`echo $NAME | perl -ne 'print lc'`
    echo "Creating Project \"$NAME\""

    # Create the project in the project directory
    cd $PA_PROJECT_DIRECTORY
    mkdir $NAME
    cd $NAME

    # Create folders within the project
    for FOLDER in ${PA_PROJECT_FOLDERS[*]}
    do
        mkdir $FOLDER
    done

    # Make the Code folder as a default
    mkdir Code
    cd Code

    # Do we want a Github repo?
    read "response?Create Github repo? (Y/n) "
    CREATE_GITHUB_REPO=${response:l}
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        # # Delete previous repo (only for testing)
        # curl --request DELETE -H "Authorization: token $PA_GITHUB_PAT" https://api.github.com/repos/wolfiezero/$LOWER_NAME

        # Create the repo and store the clone URL
        GITHUB_CLONE_URL=$(curl --request POST --data "{\"name\": \"$LOWER_NAME\", \"private\": true}" -H "Authorization: token $PA_GITHUB_PAT" https://api.github.com/user/repos | jq -r '.ssh_url')
        git clone $GITHUB_CLONE_URL

        # Checkout a develop branch
        git checkout -b develop
    else
        mkdir $LOWER_NAME
    fi

    # Open our project in the code editor
    cd $LOWER_NAME
    code .
}
