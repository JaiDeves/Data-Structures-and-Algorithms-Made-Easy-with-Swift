//
//  main.swift
//  LinkedList
//
//  Created by apple on 22/08/19.
//  Copyright © 2019 Vibrant Info. All rights reserved.
//

import Foundation


let list = LinkedList<String>()


list.append("a")
list.append("b")
list.append("c")
list.append("d")
list.append("e")
list.append("f")
list.append("g")
list.append("h")
list.append("i")
list.append("j")



//print(brute_nthNode(list: list,n: 2))
//print(pointers_nthNode(list: list,n: 2))

//list.node(at: 4).next = list.head
list.last?.next = list.node(at: 3)
print(floyd_cycle(list: list))
print(findStartOfLoop(list: list))
print(findLengthOfLoop(list: list))

