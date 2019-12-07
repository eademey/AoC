$CAPTCHA = read-host "1. GIVE THE INPUT STRING"
$CAPTCH_ARRAY = $CAPTCHA.ToCharArray()
$SUM = 0
for($i=0;$i -lt $CAPTCH_ARRAY.length; $i++){
	if($CAPTCH_ARRAY[$i] -eq $CAPTCH_ARRAY[($i+1)%$CAPTCH_ARRAY.length]){
		$SUM += ([convert]::ToInt32($CAPTCH_ARRAY[$i], 10))
	}
}
write-host "THE SUM IS $SUM"

$CAPTCHA = read-host "2. GIVE THE INPUT STRING"
$CAPTCH_ARRAY = $CAPTCHA.ToCharArray()
$SUM = 0
$OFFSETT =$CAPTCH_ARRAY.length/2
for($i=0;$i -lt $CAPTCH_ARRAY.length; $i++){
	if($CAPTCH_ARRAY[$i] -eq $CAPTCH_ARRAY[($i+$OFFSETT)%$CAPTCH_ARRAY.length]){
		$SUM += ([convert]::ToInt32($CAPTCH_ARRAY[$i], 10))
	}
}
write-host "THE SUM IS $SUM"
read-host
