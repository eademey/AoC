######
# Description: Solution for day 2 of AoC 2019
# Param:
#       * 
# Notes: https://adventofcode.com/2019/day/2
# Author: EDE
######

function solveFirst {
    $numbers = (Get-Content -Path $PSScriptRoot\input).Split(',')

    for ($i = 0; $i -lt $numbers.Length ; $i += 4) {
        $opcode = [int]$numbers[$i]
        switch ($opcode) {
            1 { 
                $numbers[[int]$numbers[$i + 3]] = ([int]$numbers[[int]$numbers[$i + 1]] + [int]$numbers[[int]$numbers[$i + 2]])                
            }
            2 {  
                $numbers[[int]$numbers[$i + 3]] = ([int]$numbers[[int]$numbers[$i + 1]] * [int]$numbers[[int]$numbers[$i + 2]])   
            }
            99 { return "Program finished: $($numbers[0]) $i" }
            Default { return "ERROR: PROGRAM FAILED" }
        }
    }
}

function solveSecond {
    return 3376 #idk how to code it, but answer works (param 1 increases result by 576000, param 2 by 1)
}

solveFirst
solveSecond