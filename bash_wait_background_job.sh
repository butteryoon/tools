#!/bin/bash  
# 
# ProgressBar : https://github.com/fearside/ProgressBar
# 

echo "wait for job"

#sleep 30 &
./drafts/progressbar.sh &
process_id=$!

echo "PID: $process_id started"

wait $process_id 

echo "Exit status: $?"

exit
