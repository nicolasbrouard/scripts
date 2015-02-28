#!/bin/bash

DIR=/home/nbrouard/Backup/site_web
pushd $DIR/mysqldump && ./backup.sh && popd 
pushd $DIR/velobrouard.net && ./backup.sh && popd
pushd $DIR/polystyvert.com && ./backup.sh && popd
pushd $DIR/polystygreen.com && ./backup.sh && popd
pushd $DIR/solenneetnicolas.net && ./backup.sh && popd
pushd $DIR/baugycyclo.net && ./backup.sh && popd
pushd $DIR/cribri.velobrouard.net && ./backup.sh && popd
pushd $DIR/skimco.ca && ./backup.sh && popd
