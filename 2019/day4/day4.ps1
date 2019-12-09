######
# Description: Solution for day 4 of AoC 2019
# Param:
#       * 
# Notes: https://adventofcode.com/2019/day/4
# Author: EDE
######

function solveFirst {
    param(
        [int]$start,
        [int]$end
    )
    $total = 0

    #Could loop every number between, bad performance
    
    $lowest_possible = [math]::Floor($start / 100000)
    
    foreach ($one in ($lowest_possible..9)) {
        foreach ($two in ($one..9)) {
            foreach ($three in ($two..9)) {
                foreach ($four in ($three..9)) {
                    foreach ($five in ($four..9)) {
                        foreach ($six in ($five..9)) {
                            if (
                                ($one -eq $two) -or
                                ($two -eq $three) -or
                                ($three -eq $four) -or
                                ($four -eq $five) -or
                                ($five -eq $six)
                            ) {
                                $nr = $six + 10 * $five + 100 * $four + 1000 * $three + 10000 * $two + 100000 * $one
                                if (($nr -ge $start) -and ($nr -le $end)) {
                                    $total++
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return $total
}

function solveSecond {
    param(
        [int]$start,
        [int]$end
    )
    $total = 0

    #Could loop every number between, bad performance
    
    $lowest_possible = [math]::Floor($start / 100000)
    
    foreach ($one in ($lowest_possible..9)) {
        foreach ($two in ($one..9)) {
            foreach ($three in ($two..9)) {
                foreach ($four in ($three..9)) {
                    foreach ($five in ($four..9)) {
                        foreach ($six in ($five..9)) {
                            $nr = $six + 10 * $five + 100 * $four + 1000 * $three + 10000 * $two + 100000 * $one
                            $checkedThis = $false
                            foreach ($i in ($lowest_possible..9)) {
                                $count = ($nr.ToString().ToCharArray() | Where-Object {$_ -eq $i.ToString() } | Measure-Object).Count
                                if (($nr -ge $start) -and ($nr -le $end) -and $count -eq 2 -and !$checkedThis) {
                                    $total++
                                    $checkedThis = $true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return $total
}

solveFirst -start 172930 -end 683082
solveSecond -start 172930 -end 683082
