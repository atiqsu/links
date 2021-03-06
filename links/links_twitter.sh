#!/bin/bash

# Set this
ROOT=/home/user/links

# Shouldn't have to set these
PARSETWITTER=$ROOT/parsetwitter.pl
VAR_LOG=$ROOT/logs/links_twitter.log

# Don't set these
PDIR=${0%`basename $0`}
LCK_FILE=$ROOT/`basename $0`.lck


if [ -f "${LCK_FILE}" ]; then

  # The file exists so read the PID
  # to see if it is still running
  MYPID=`head -n 1 "${LCK_FILE}"`

  TEST_RUNNING=`ps -p ${MYPID} | grep ${MYPID}`

  if [ -z "${TEST_RUNNING}" ]; then

    # The process is not running
    # Echo current PID into lock file
    # echo "Not running"
    echo $$ > "${LCK_FILE}"

  else

    echo "`date` `basename $0` is already running [${MYPID}]" >> $VAR_LOG
    #echo "Already running[${MYPID}]: `date`" >> $VAR_LOG

    exit 0

  fi

else

    #echo "Not running"
    echo $$ > "${LCK_FILE}"
fi


    echo `date` >> $VAR_LOG
    
    $PARSETWITTER &>> $VAR_LOG
    
    rm -f "${LCK_FILE}"


exit 0
