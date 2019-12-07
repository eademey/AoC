######
# Description: Solution for day 1 of AoC 2019
# Param:
#       * 
# Notes: https://adventofcode.com/2019/day/1
# Author: EDE
######

function solveFirst {
    $totalFuel = 0
    foreach ($line in Get-Content -Path $PSScriptRoot\input) {
        $totalFuel += [math]::floor(([int]$line) / 3) - 2
    }
    return $totalFuel
}

function solveSecond{
    $totalFuel = 0
    foreach ($line in Get-Content -Path $PSScriptRoot\input) {
        $moduleFuel = [math]::floor(([int]$line) / 3) - 2
        $addedFuel = $moduleFuel
        while($addedFuel -gt 0){
            $addedFuel = [math]::Max([math]::floor(([int]$addedFuel) / 3) - 2,0)
            $moduleFuel += $addedFuel
        }
        $totalFuel += $moduleFuel
    }
    return $totalFuel
}

solveFirst
solveSecond