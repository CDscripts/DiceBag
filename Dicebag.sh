#! /bin/bash

# expected data format: number of rolls; number of Sides; number to add
function mainMenu() {
	clear

	local totalCharacters=$(ls -1q *.dice | wc -l | xargs )
	local characterList=$(ls | grep .dice | cut -d'.' -f1 | xargs)
	local counter=1
	local uInput


	echo "Available characters:"
	for character in $characterList; do
		echo "$counter: $character"
		counter=$(( $counter+ 1 ))
	done
	echo "N for new character, currently depreciated"
	echo "character number, (N)ew character, (D)elete character, (E)xit"
	read uInput
	echo $uInput

	#case statement to make a new file, read an old file, or quit.
}

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

mainMenu
while read line
do
	echo $line
done <  cody.dice


dicebag=("1,20,5" "6,6,5")


for dice in "${dicebag[@]}"; do

	rollerCutter $dice
done
