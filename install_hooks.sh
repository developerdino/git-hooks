#!/usr/bin/env bash

# Install git hooks.
# This should be run as part of a post install script in composer.

HOOKS="pre-commit.d"

CONFIG_FILE=$(dirname $0)/config
if [ -e ${CONFIG_FILE} ]; then
    . ${CONFIG_FILE}
fi


. "$(dirname -- "$0")/canonicalize_filename.sh"

# exit on error
set -e

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT="$(canonicalize_filename "$0")"

# Absolute path this script is in, e.g. /home/user/bin/
SCRIPT_PATH="$(dirname -- "$SCRIPT")"

# copy hooks to the directory specified as parameter
copy_hooks() {
    # echo "Copying hooks to destination directory:"
    for hook in ${HOOKS}
    do
        echo "Copying $hook to $1/hooks."
        cp -R -- "$SCRIPT_PATH/$hook" "$1/hooks" || true
    done

    # echo "Checking if hooks are executable:"
    for hook in ${HOOKS}
    do
        suffix=${hook/.d/}
        for file in "$1/hooks/$hook/*$suffix"
        do
            if [ ! -x "$file" ] ; then
                chmod +x ${file}
            fi
        done
    done
}

echo "Git hooks installation."
if [ -d ".git" ] ; then
    # create hooks subfolder if it does not yet exist
    mkdir -p -- ".git/hooks"

    cp -f -- "$SCRIPT_PATH/canonicalize_filename.sh" ".git/hooks/" || true
    cp -f -- "$SCRIPT_PATH/pre-commit" ".git/hooks/" || true
    copy_hooks ".git"
    chmod +x ".git/hooks/pre-commit"
else
    echo "Error: .git does not exist."
    echo "Are you sure `pwd` is the root directory of your local git repository?"
fi
