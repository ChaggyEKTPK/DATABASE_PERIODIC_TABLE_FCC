#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Add argument check to element.sh
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# Support symbol and name lookup
if [[ $1 =~ ^[0-9]+$ ]]
then
  CONDITION="e.atomic_number = $1"
else
  CONDITION="e.symbol = '$1' OR e.name = '$1'"
fi

# Query element by atomic number
ELEMENT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
 FROM elements e
  INNER JOIN properties p USING(atomic_number)
   INNER JOIN types t USING(type_id)
    WHERE e.atomic_number = $1")

#handle element not found
if [[ -z $ELEMENT ]]
then
  echo "I could not find that element in the database."
  exit
fi

IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING <<< "$ELEMENT"

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling of $BOILING celsius."
