//
//  FindLength.swift
//  LinkedList
//
//  Created by apple on 30/08/19.
//  Copyright © 2019 Vibrant Info. All rights reserved.
//

import Foundation


func findLengthOfLoop<T>(list:LinkedList<T>)->Int{
    var lengthOfLoop = 0
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
        lengthOfLoop += 1
        while  fasterNode! !== slowNode!{
            fasterNode = fasterNode?.next
            lengthOfLoop += 1
        }
    }
    
    return lengthOfLoop
}
