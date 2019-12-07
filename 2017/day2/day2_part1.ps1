$CON = "y"	#unecessary, just to not have to restart the program every time a new input is tested
while($CON -eq "y"){
	$INPUT = get-content input.txt
	$LINES = $INPUT -split '\n'
	$CHECKSUM = 0
	foreach($LINE in $LINES){
		$NUMBERS = $LINE -split '\s+'
		$NUMBERS = $NUMBERS | Sort-Object {[int]$_}
		$CHECKSUM += (([convert]::ToInt32($NUMBERS[$NUMBERS.length-1], 10))-([convert]::ToInt32($NUMBERS[0], 10)))
	}
	write-host "THE CHECKSUM IS $CHECKSUM"
	$CON = read-host "DO YOU WISH TO CONTINUE?:" 
}
