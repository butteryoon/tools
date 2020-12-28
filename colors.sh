#!/bin/bash

COLORS=( 
"\e[30mBlack"
"\e[31mRed"
"\e[32mGreen"
"\e[33mYellow"
"\e[34mBlue"
"\e[35mMagenta"
"\e[36mCyan"
"\e[37mWhite"
"\e[90mBright Black"
"\e[91mBright Red"
"\e[92mBright Green"
"\e[93mBright Yellow"
"\e[94mBright Blue"
"\e[95mBright Magenta"
"\e[96mBright Cyan"
"\e[97mBright White"
)

for ((i = 0; i < ${#COLORS[@]}; i++))
do
    echo -e ${COLORS[$i]}
done
