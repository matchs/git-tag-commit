#!/bin/sh

# Checking if a token was provided. Otherwise, abort
if [ ! -n "$WERCKER_GIT_TAG_COMMIT_TOKEN"]
then
  fail "Missing token. See how to obtain that on https://github.com/settings/tokens/new"
else
  token="$WERCKER_GIT_TAG_COMMIT_TOKEN"
fi

# Checking if a tag name was provided. Otherwise, abort
if [ ! -n "$WERCKER_GIT_TAG_COMMIT_TAG"]
then
  fail "Missing tag name. Please provide one"
else
  tag="$WERCKER_GIT_TAG_COMMIT_TAG"
fi

# Checking if a repository was provided. Otherwise, use default
if [ -n "$WERCKER_GIT_TAG_COMMIT_REPOSITORY" ]
then
  repo="$WERCKER_GIT_TAG_COMMIT_REPOSITORY"
  info "Using repository \"$repo\""
else
  repo="$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY"
  info "No repository selected. Using default \"$repo\""
fi

# Checking if a branch was provided. Otherwise, use default
if [ -n "$WERCKER_GIT_TAG_COMMIT_BRANCH" ]
then
  branch="$WERCKER_GIT_TAG_COMMIT_BRANCH"
  info "Using branch \"$branch\""
else
  branch="$WERCKER_GIT_BRANCH"
  info "No branch selected. Using default \"$branch\""
fi

# Checking if a commit was provided. Otherwise, use default
if [ -n "$WERCKER_GIT_TAG_COMMIT_COMMIT" ]
then
  commit="$WERCKER_GIT_TAG_COMMIT_COMMIT"
  info "Using commit \"$commit\""
else
  commit="$WERCKER_GIT_COMMIT"
  info "No commit selected. Using default \"$commit\""
fi

#Only try to push tag if the step is successful
if [ "$WERCKER_RESULT" = "passed" ]; 
then
    

    # Configure git
    git config --global user.email pleasemailus@wercker.com
    git config --global user.name "wercker"
    debug 'configured git'

    remote="https://$tag@github.com/$repo"

    # Get tags.
    sudo mkdir /tmp/repo
    sudo chmod 777 /tmp/repo
    cd /tmp/repo
    git init
    git remote add origin $remote
    git fetch --tags 
    debug 'fetched git tags'

    # Delete the tag if it exists, otherwise just skip
    if [git tag -l | grep "$tag" &> /dev/null];
    then
        git tag -d "$tag"
        debug 'Deleted existing tag'
    fi

    # Tag your commit.
    git tag $tag
    git push --tags 
    info "Pushed tag \"$tag\" to \"$repository\""
else
    info "Skipping, your deploy result was $WERCKER_RESULT"
fi
