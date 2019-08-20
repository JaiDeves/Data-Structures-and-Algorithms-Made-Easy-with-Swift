//: Playground - noun: a place where people can play
import Foundation
import PlaygroundSupport


func iterativeBinaySearch<T:Comparable>(array:[T],key:T)->Int{
    var low = 0, high = array.count, mid = 0
    
    while low < high {
        mid = low + (high - low) / 2
        if(array[mid] == key){
            return mid
        }else if (array[mid] > key){
            high = mid - 1
        }else{
            low = mid + 1
        }
    }
    return -1
}


func recusriveBinaySearch<T:Comparable>(array:[T],key:T,low:Int,high:Int)->Int{
    
    let mid = low + (high - low) / 2
    print("high = \(high)")
    print(" low = \(low)")
    print("   mid = \(mid) \n")
    
    if( high < low){
        return -1
    }
    if(array[mid] == key){
        return mid
    }else if (array[mid] > key){
        return recusriveBinaySearch(array: array, key: key, low: low, high: mid - 1)
    }else{
        return recusriveBinaySearch(array: array, key: key, low: mid + 1, high: high )
    }
}





//let array = [2,3,5,8,9,14,15,16,17,19,20,22,25,27,29,40]
let array = [1,3,5,8,12,13,15,16,18,20,22,30,40,50,55,67]
let result = recusriveBinaySearch(array: array, key: 13, low: 0, high: array.count)
//let result = iterativeBinaySearch(array: [2,3,5,8,9,14,6], key: 14)
if (result != -1){
    print("item found at \(result)")
}else{
    print("item not found")
}

