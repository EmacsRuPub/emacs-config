#!/bin/sh
#
# Use this script as your EDITOR to allow editing remote files with emacsclient.
# Works by connecting to the Emacs machine with SSH and using a suitable tramp prefix.

# How to reach this machine from the one that's running Emacs
ME=user@remote-host

# How to reach the machine that's running Emacs from this machine
THEY=user@host-running-emacs

if [ "${1#/}" != "$1" ]; then
    # absolute path
    exec ssh $THEY "emacsclient /$ME:$1"
else
    # relative path
    PWD=$(pwd)
    exec ssh $THEY "emacsclient /$ME:$PWD/$1"
fi