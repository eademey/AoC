$CON = "y"	#unecessary, just to not have to restart the program every time a new input is tested
while($CON -eq "y"){
	$INPUT = get-content input.txt
	$LINES = $INPUT -split '\n'
	$CHECKSUM = 0
	foreach($LINE in $LINES){
		$NUMBERS = $LINE -split '\s+'
		for($i = 0; $i -lt $NUMBERS.length; $i++){
			for($j = 0; $j -lt $NUMBERS.length; $j++){
				$VAL_I = [int]::parse($NUMBERS[$i])
				$VAL_J = [int]::parse($NUMBERS[$j])
				if($i -ne $j -and ($VAL_I%$VAL_J)-eq 0){
					$CHECKSUM += $VAL_I/$VAL_J
				}
			}
		}
	}
	write-host "THE CHECKSUM IS $CHECKSUM"
	$CON = read-host "DO YOU WISH TO CONTINUE?:" 
}
