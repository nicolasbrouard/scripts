#!/bin/sh

rsync -avzh --progress --del --filter=". filter-list" solennee@server2.websitehostserver.net:skimco.ca/* git

cd git
git add --all .
git commit -a -m "Backup du `date`"
cd ..
