$INPUT = get-content input.txt
$DIRECTIONS = $INPUT -split ','
$X = 0
$Y = 0
$FURTHEST = 0
foreach($DIRECTION in $DIRECTIONS){
	if($DIRECTION.contains('n')){
		if($DIRECTION.contains('e')){
			$X+= 1
			$Y+= 1
		}elseif($DIRECTION.contains('w')){
			$X-= 1
			$Y+= 1
		}else{
			$Y+=2
		}
	}else{
		if($DIRECTION.contains('e')){
			$X+=1
			$Y-=1
		}elseif($DIRECTION.contains('w')){
			$X-=1
			$Y-=1
		}else{
			$Y-=2
		}
	}
	$FURTHEST = [math]::max(([math]::abs($X) + [math]::abs($Y))/2, $FURTHEST)
}
$RESULT = ([math]::abs($X) + [math]::abs($Y))/2
write-host "The result is: $RESULT"
write-host "The max value was: $FURTHEST"
read-host