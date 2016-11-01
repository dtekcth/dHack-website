#!/bin/sh

#
# Copyright 2016 Emil Hemdal
#
# This file is part of dHack-website.
#
# dHack-website is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# dHack-website is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with dHack-website.  If not, see <http://www.gnu.org/licenses/>.
#

# Check so that Node.js is installed, exit otherwise.
if [! type "node" > /dev/null]; then
    echo "Node.js doesn't seem to be installed!"
    exit 1
fi

# We want this script's directory.
SCRIPT=$(readlink -f "$0")

SCRIPTPATH=$(dirname "$SCRIPT")

# Check if release folder doesn't exist.
if [ ! -d "${SCRIPTPATH}/release" ]; then
    # Create release and revisions folder.
    mkdir --parents "${SCRIPTPATH}/release/revisions"
else
    # Release folder exists, check if revisions folder doesn't exist.
    if [ ! -d "${SCRIPTPATH}/release/revisions" ]; then
        # Create revisions folder.
        mkdir "${SCRIPTPATH}/release/revisions"
    fi
fi

# Get the amount of files in revisions.
FILEAMOUNT=$(ls ${SCRIPTPATH}/release/revisions | wc -l)

# If the amount of files is greater than 0 then set the last file's number to
# LASTFILENUMBER otherwise set to 0.
if [ $FILEAMOUNT -gt 0 ]; then
    # The v flag is important to natural sort numbers!
    LASTFILENUMBER=$(ls -v ${SCRIPTPATH}/release/revisions | tail -n 1)
else
    LASTFILENUMBER=0
fi

# Add LASTFILENUMBER by 1
LASTFILENUMBER=`expr $LASTFILENUMBER + 1`

NEWREVISIONFOLDER="${SCRIPTPATH}/release/revisions/$LASTFILENUMBER"

# Create new revisions folder
mkdir $NEWREVISIONFOLDER


# TODO: process and copy files to the new revisions folder.


# Create/update symbolic link to point to the new revision.

# The n flag lets ln treat current as a symbolic link rather than a folder.
# The f flag forces the update of the symbolic link.
# The r flag creates a relative symbolic link.
ln -s -n -r -f $NEWREVISIONFOLDER ${SCRIPTPATH}/release/current

