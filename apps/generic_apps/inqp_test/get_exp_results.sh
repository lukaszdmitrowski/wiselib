#!/bin/bash

HOST=wilabfs.atlantis.ugent.be
USER=hasemann
LOGS_DIR=iPlatform/inqp_platform/log

EXP_ID=$1

if [ -z "$EXP_ID" ]; then
	EXP_ID=$(ssh $USER@$HOST "cd $LOGS_DIR; ls -1d 2*"|sort|tail -n 1)
fi

echo Getting logs for experiment $EXP_ID ....
rsync -CHaPx $USER@$HOST:$LOGS_DIR/$EXP_ID .
#rsync -CHaPx $USER@$HOST:$LOGS_DIR/ ./

echo Dumping SQL databases for experiment $EXP_ID ....

echo "SELECT * FROM inqp_${EXP_ID}_1242" | ssh $USER@$HOST "mysql -B -h www.wilab.atlantis.ugent.be -uhasemann -preude123 hasemann " >  ${EXP_ID}.csv

