######
# Description: Solution for day 6 of AoC 2019
# Param:
#       * 
# Notes: https://adventofcode.com/2019/day/6 | Orbit map = tree
# Author: EDE
######

function createTreeNode {
    param(
        $Name
    )
    return [PSCustomObject]@{
        Name     = $Name
        Children = [System.Collections.Generic.List[String]]@()
    }
}

function getNodeList {
    $map = Get-Content -Path $PSScriptRoot\input

    $nodes = @{ }

    foreach ($line in $map) {
        $splitted = $line.Split(')')
        #Add parent first
        if (!($nodes.ContainsKey($splitted[0]))) {
            $newObj = createTreeNode $splitted[0]
            $null = $nodes.Add($splitted[0], $newObj)
        }
        $nodes[$splitted[0]].Children.Add($splitted[1])
        if (!($nodes.ContainsKey($splitted[1]))) {
            $newObj = createTreeNode $splitted[1]
            $null = $nodes.Add($splitted[1], $newObj)
        }
    }
    return $nodes
}

function countOrbits {
    param(
        $NodeName,
        $NodeList,
        $Depth
    )
    $Node = $NodeList[$NodeName]

    $total = $Depth
    foreach ($child in $Node.Children) {
        $total += countOrbits -NodeName $child -NodeList $NodeList -Depth $($Depth + 1)
    }

    return $total
}

function solveFirst {
    $nodes = getNodeList

    return countOrbits -NodeName 'COM' -Depth 0 -NodeList $nodes
}

function findPathToNode {
    param(
        $node,
        $nodelist,
        $goal
    )

    foreach ($child in $nodelist[$node].Children) {
        if ($child -eq $goal) {
            return "${node}-${goal}"
        }
        else {
            $out = findPathToNode -node $child -nodelist $nodelist -goal $goal
            if ($out) {
                return "${node}-${out}"
            }
        }
    }
}

function solveSecond {
    $nodes = getNodeList

    #Get paths to nodes
    $youPath = findPathToNode -node 'COM' -nodelist $nodes -goal 'YOU'
    $sanPath = findPathToNode -node 'COM' -nodelist $nodes -goal 'SAN'

    #Find deepest common node
    $splitYou = $youPath.split('-')
    $splitSan = $sanPath.Split('-')

    $i = 0
    while ($splitYou[$i + 1] -eq $splitSan[$i + 1]) {
        $i++
    }

    $splitYou[$i..$($splitYou.Length - 1)].Length
    
    return $splitYou[$i..$($splitYou.Length - 1)].Length + $splitSan[$i..$($splitSan.Length - 1)].Length - 4 #-4 to compensate for counting first + final nodes
}

solveFirst
solveSecond