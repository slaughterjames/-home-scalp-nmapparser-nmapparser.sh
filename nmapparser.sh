#!/bin/bash -
#===============================================================================
#nmapparser v0.1 - Copyright 2019 James Slaughter,
#This file is part of nmapparser v0.1.

#nmapparser v0.1 is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#nmapparser v0.1 is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with nmapparser v0.1.  If not, see <http://www.gnu.org/licenses/>.
#===============================================================================
#------------------------------------------------------------------------------
#
# Execute amasstrigger on top of an Ubuntu-based Linux distribution.
#
#------------------------------------------------------------------------------

__ScriptVersion="nmapparser-v0.1"
LOGFILE="/home/tools/nmapparser.log"
ARG1=$1

echoerror() {
    printf "${RC} [x] ${EC}: $@\n" 1>&2;
}

echoinfo() {
    printf "${GC} [*] ${EC}: %s\n" "$@";
}

echowarn() {
    printf "${YC} [-] ${EC}: %s\n" "$@";
}

usage() {
    echo "usage: nmapparser.sh <gnmap file>"
    exit 1
}

initialize() {
  echoinfo "--------------------------------------------------------------------------------" >> $LOGFILE
  echoinfo "Running nmapparser.sh version $__ScriptVersion on `date`" >> $LOGFILE
  echoinfo "--------------------------------------------------------------------------------" >> $LOGFILE

  echoinfo "---------------------------------------------------------------"
  echoinfo "Running nmapparser.sh version $__ScriptVersion on `date`"
  echoinfo "---------------------------------------------------------------"
}

pipe_to_nmap_data() {
 
  #Target 
  echoinfo "Target file is: $ARG1" 

  #
  echoinfo "Piping program execution to grep..."
  echoinfo "Piping program execution to grep..." >> $LOGFILE
  echo $(grep -E "80/open|443/open" $ARG1 > $ARG1-grep.txt) >> $LOGFILE
  echoinfo "File $ARG1-grep.txt created..."

  echoinfo "Piping program execution to sed and removing Host..."
  echoinfo "Piping program execution to sed and removing Host..." >> $LOGFILE
  echo $(sed -n 's/Host: //p' $ARG1-grep.txt > $ARG1-sed.csv) >> $LOGFILE
  echoinfo "File $ARG1-sed.csv created..."

  echoinfo "Piping program execution to sed and inserting commas..."
  echoinfo "Piping program execution to sed and inserting commas..." >> $LOGFILE
  echo $(sed -i 's/(/,(/1' $ARG1-sed.csv) >> $LOGFILE
  echoinfo "File $ARG1-sed.csv ready..."

  rm $ARG1-grep.txt

  return 0
}

wrap_up() {
  echoinfo "--------------------------------------------------------------------------------" >> $LOGFILE
  echoinfo "Program complete on `date`" >> $LOGFILE
  echoinfo "--------------------------------------------------------------------------------" >> $LOGFILE

  echoinfo "---------------------------------------------------------------"
  echoinfo "Program complete on `date`"
  echoinfo "---------------------------------------------------------------"
}

#Function calls
initialize
if [ ! -z "$1" ]
then
  pipe_to_nmap_data
else
  usage
fi
wrap_up
