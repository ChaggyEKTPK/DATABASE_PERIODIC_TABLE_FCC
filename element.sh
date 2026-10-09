#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Add argument check to element.sh
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# Query element by atomic number
if [[ $1 =~ ^[0-9]+$ ]]
then
  CONDITION="e.atomic_number = $1"
else
  CONDITION="e.symbol = '$1' OR e.name = '$1'"
fi
