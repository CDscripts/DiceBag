#! /bin/bash

# expected data format: number of rolls; number of Sides; number to add

function roller(){
	#giving incoming variables names, keeping format that DND uses
	local diceNumber=$1
	local diceSides=$2
	local diceAdjust=$3
	local diceTotal=0

	echo "inside Roller: $diceNumber, $diceSides, $diceAdjust"


	while [ $diceNumber -gt  0 ]
	do
		diceTotal=$(( $diceTotal + $RANDOM % $diceSides ))
		diceNumber=$(( $diceNumber-1 ))
	done

        diceTotal=$(( $diceTotal + $diceAdjust ))

	echo "$diceTotal"
}

function rollerCutter(){
	#dividing string into the parts needed to roll
	local diceNumber=$( echo $1 | cut -d',' -f1 | xargs)
	local diceSides=$( echo $1 | cut -d',' -f2 | xargs)
	local diceAdjust=$( echo $1 | cut -d',' -f3 | xargs)
	
	local result=$(roller $diceNumber $diceSides $diceAdjust)
	echo "result: $result"
}

touch cody.dice
echo "1,20,6" >> cody.dice

while read line
do
	echo $line
done <  cody.dice


dicebag=("1,20,5" "6,6,5")


for dice in "${dicebag[@]}"; do

	rollerCutter $dice
done
