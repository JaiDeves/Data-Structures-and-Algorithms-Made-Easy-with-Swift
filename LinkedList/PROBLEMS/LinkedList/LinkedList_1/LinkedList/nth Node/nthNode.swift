//
//  nthNode.swift
//  LinkedList
//
//  Created by apple on 22/08/19.
//  Copyright © 2019 Vibrant Info. All rights reserved.
//

import Foundation



/// Find nth node from the end of the linkedlist ?

//Brute-Force
/*
 
 T(n) = O(n) + O(n) = O(n)
 O(n) -> finding the length
 O(n) -> finding the nth node
 
 :2 scans are required
 */
func brute_nthNode<T>(list:LinkedList<T>,n:Int)->T?{
    let count = list.count
    guard n <= count else { return nil }
    var current = list.head
    for _ in 0..<count - n {
        current = current?.next
    }
    return current?.value
}



// with only one scan?
/*
 Using two pointers
 T(n) = O(n)
 S(n) = O(1)
 */

func pointers_nthNode<T>(list:LinkedList<T>,n:Int)->T?{
    
    var temp = list.head
    var nth = list.head
    
    for _ in 0..<n{
        temp = temp?.next
    }
    while temp != nil {
        temp = temp?.next
        nth = nth?.next
    }
    return nth?.value
}


