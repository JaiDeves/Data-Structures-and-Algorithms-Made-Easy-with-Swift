//
//  CheckCycle.swift
//  LinkedList
//
//  Created by apple on 26/08/19.
//  Copyright © 2019 Vibrant Info. All rights reserved.
//


/// Check whether the given linked list is either NULL-terminated or ends in a cycle??

import Foundation

func floyd_cycle<T>(list:LinkedList<T>)->Bool{
    var slowNode = list.head
    var fasterNode = list.head
    
    while slowNode != nil && fasterNode != nil && fasterNode?.next != nil {
        slowNode = slowNode?.next
        fasterNode = fasterNode?.next?.next
        if let slow = slowNode, let fast = fasterNode {
            if slow === fast{
                return true
            }
        }
    }
    return false
    
}



