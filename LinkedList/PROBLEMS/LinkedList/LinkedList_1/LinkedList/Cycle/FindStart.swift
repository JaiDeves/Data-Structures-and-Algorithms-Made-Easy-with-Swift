//
//  FindStart.swift
//  LinkedList
//
//  Created by apple on 27/08/19.
//  Copyright © 2019 Vibrant Info. All rights reserved.
//

/// Check whether the list is NULL-terminted or not. If there is a cycle find the start node of the loop

import Foundation


/// Flyod cycle works based on Number theory, if we notice that the slow and fast pointer will meet when they are are n * L, where L is the loop length. Also, the slow pointer is at the midpoint between the beginning of the sequence & the fast pointer because of the way they move.

// Therefore slow pointer is n * L away from the beginning of the sequence.
// So just need to move the pointers one step at a time to meet, since already one the faster pointer is in the loop and is at a distance of n * L.

func findStartOfLoop<T>(list:LinkedList<T>)->T?{
    var slowNode = list.head
    var fasterNode = list.head
    var isLoop = false
    //Floyd cycle
    while slowNode != nil && fasterNode != nil && fasterNode?.next != nil {
        slowNode = slowNode?.next
        fasterNode = fasterNode?.next?.next
        if let slow = slowNode, let fast = fasterNode {
            if slow === fast{
                isLoop = true
                break
            }
        }
    }
    
    if isLoop{
        slowNode = list.head
        while let slow = slowNode, let fast = fasterNode, slow !== fast{
            fasterNode = fasterNode?.next
            slowNode = slowNode?.next
        }
        return slowNode?.value
    }
    
    return nil
}
