#!/bin/sh

#########################################################
# Script to do incremental rsync backups
# Adapted from script found on the rsync.samba.org
# Brian Hone 3/24/2002
# This script is freely distributed under the GPL
#########################################################

##################################
# Configure These Options
##################################

###################################
# directory to backup
# - This is the path to the directory you want to archive
###################################
BACKUPDIR=/var/lib/jenkins

###################################
# excludes file - contains one wildcard pattern per line of files to exclude
#  - This is a rsync exclude file.  See the rsync man page and/or the
#    example_exclude_file
###################################
EXCLUDES=backup-exclude-files

###################################
# root directory to for backup stuff
###################################
DESTINATION=jenkins@mt-nbrouard4.nuance.com
ARCHIVEROOT=/mnt/Backup/som-jenkins01

#########################################
# From here on out, you probably don't  #
#   want to change anything unless you  #
#   know what you're doing.             #
#########################################

# directory which holds our current datastore
CURRENT=main

# directory which we save incremental changes to
INCREMENTDIR=`date +%Y-%m-%d`

# options to pass to rsync
OPTIONS="--force --ignore-errors --delete-excluded \
 --exclude-from=$EXCLUDES --backup --backup-dir=$ARCHIVEROOT/$INCREMENTDIR -avh"

export PATH=$PATH:/bin:/usr/bin:/usr/local/bin

# make sure our backup tree exists
#install -d $ARCHIVEROOT/$CURRENT

# our actual rsyncing function
do_rsync()
{
   rsync -e "ssh -i /home/nbrouard-admin/.ssh/id_rsa" $OPTIONS $BACKUPDIR $DESTINATION:$ARCHIVEROOT/$CURRENT
}

# some error handling and/or run our backup and accounting
if [ -f $EXCLUDES ]; then
 if [ -d $BACKUPDIR ]; then
  # now the actual transfer
  do_rsync
 else
  echo "cannot find $BACKUPDIR"; exit
 fi
 else
  echo "cannot find $EXCLUDES"; exit
fi

